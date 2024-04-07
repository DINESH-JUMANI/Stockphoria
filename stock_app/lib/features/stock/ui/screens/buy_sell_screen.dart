import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/features/chart/ui/screens/chart_screen.dart';
import 'package:stock_app/features/chart/ui/widgets/show_chart.dart';
import 'package:stock_app/common/global_widgets.dart';
import 'package:stock_app/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';

import 'package:stock_app/features/wallet/bloc/wallet_bloc.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/watchlist/bloc/watchlist_bloc.dart';

class BuySellScreen extends StatefulWidget {
  final StockModel stock;

  const BuySellScreen({super.key, required this.stock});

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  final quantityController = TextEditingController();
  String range = "1y";
  String interval = "1d";
  double availableBalance = 0;
  List<Portfolio> buyedStocks = [];
  List<StockModel> watchlistedStocks = [];
  bool isWatchlisted = false;
  final WalletBloc walletBloc = WalletBloc();
  final PortfolioBloc portfolioBloc = PortfolioBloc();
  final WatchlistBloc watchlistBloc = WatchlistBloc();

  void buyStock() {
    if (quantityController.text.isEmpty) {
      GlobalWidgets().showSnackBar(context, Colors.red, "Enter quantity");
      return;
    }
    Portfolio portfolio;
    double buyingPrice = widget.stock.price;
    int quantityBuyed = int.parse(quantityController.text);
    double totalAmount = buyingPrice * quantityBuyed;
    if (availableBalance < totalAmount) {
      GlobalWidgets().showSnackBar(context, Colors.red, "Insufficient Balance");
      return;
    }
    portfolio = Portfolio(
      userId: "user",
      stockName: widget.stock.shortName,
      buyingPrice: buyingPrice,
      quantityBuyed: quantityBuyed,
      totalAmount: totalAmount,
    );
    portfolioBloc.add(PortfolioBuyEvent(portfolio));
    walletBloc.add(BalanceDecrementEvent(totalAmount));
    portfolioBloc.add(PortfolioFetchEvent());
    walletBloc.add(BalanceFetchEvent());
    GlobalWidgets().showSnackBar(context, Colors.green, 'Buyed Successfully');
  }

  void sellStock() {
    if (quantityController.text.isEmpty) {
      GlobalWidgets().showSnackBar(context, Colors.red, 'Enter Quantity');
      return;
    }
    Portfolio portfolio;
    double buyingPrice = widget.stock.price;
    int quantityBuyed = int.parse(quantityController.text);
    double totalAmount = buyingPrice * quantityBuyed;
    int availableQuantity = 0;
    for (int i = 0; i < buyedStocks.length; i++) {
      if (buyedStocks[i].stockName == widget.stock.shortName) {
        availableQuantity = buyedStocks[i].quantityBuyed;
        break;
      }
    }
    if (availableQuantity < quantityBuyed) {
      GlobalWidgets()
          .showSnackBar(context, Colors.red, 'Insufficient Quantity');
      return;
    }
    portfolio = Portfolio(
      userId: "user",
      stockName: widget.stock.shortName,
      buyingPrice: buyingPrice,
      quantityBuyed: quantityBuyed,
      totalAmount: totalAmount,
    );
    portfolioBloc.add(PortfolioSellEvent(portfolio));
    walletBloc.add(BalanceIncrementEvent(totalAmount));
    portfolioBloc.add(PortfolioFetchEvent());
    walletBloc.add(BalanceFetchEvent());
    GlobalWidgets().showSnackBar(context, Colors.green, 'Sold Successfully');
  }

  void watchlistButton() {
    if (!isWatchlisted) {
      watchlistBloc.add(WatchlistAddEvent(widget.stock));

      GlobalWidgets().showSnackBar(context, Colors.green, "Added to watchlist");
      watchlistBloc.add(WatchlistFetchEvent());
    } else {
      watchlistBloc.add(WatchlistRemoveEvent(widget.stock));
      GlobalWidgets()
          .showSnackBar(context, Colors.green, "Removed from watchlist");
      watchlistBloc.add(WatchlistFetchEvent());
    }
    setState(() {});
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    walletBloc.add(BalanceFetchEvent());
    portfolioBloc.add(PortfolioFetchEvent());
    watchlistBloc.add(WatchlistFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          BlocConsumer<WatchlistBloc, WatchlistState>(
            bloc: watchlistBloc,
            listenWhen: (previous, current) => current is WatchlistActionState,
            buildWhen: (previous, current) => current is! WatchlistActionState,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case WatchlistFetchingLoadingState:
                  return const Icon(Icons.bookmark_border);
                case WatchlistFetchingSuccessfulState:
                  final successState =
                      state as WatchlistFetchingSuccessfulState;
                  watchlistedStocks = successState.watchlistedStocks;
                  for (var stock in watchlistedStocks) {
                    if (stock.symbol == widget.stock.symbol) {
                      isWatchlisted = true;
                      break;
                    }
                  }
                  return InkWell(
                    onTap: watchlistButton,
                    child: isWatchlisted
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border),
                  );
                default:
                  log("default");
                  return const Icon(Icons.bookmark_border);
              }
            },
          ),
        ],
        title: Text(
          widget.stock.shortName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChartScreen(
                      symbol: widget.stock.symbol,
                    ),
                  ),
                ),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  child: ShowChart(
                    symbol: widget.stock.symbol,
                    interval: interval,
                    range: range,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        range = "1d";
                        interval = "60m";
                      });
                    },
                    child: Text('1D'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        range = "5d";
                        interval = "60m";
                      });
                    },
                    child: Text('5D'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        range = "5mo";
                        interval = "1d";
                      });
                    },
                    child: Text('5M'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        range = "1y";
                        interval = "1d";
                      });
                    },
                    child: Text('1Y'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        range = "5y";
                        interval = "1d";
                      });
                    },
                    child: Text('5Y'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Quantity')),
              ),
              const SizedBox(height: 20),
              Text(
                "Price: ${widget.stock.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              BlocConsumer<WalletBloc, WalletState>(
                bloc: walletBloc,
                listenWhen: (previous, current) => current is WalletActionState,
                buildWhen: (previous, current) => current is! WalletActionState,
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case BalanceFetchingLoadingState:
                      return GlobalWidgets().splashScreen();
                    case BalanceFetchingSuccessfulState:
                      final successState =
                          state as BalanceFetchingSuccessfulState;
                      availableBalance = successState.balance;

                      return Text(
                        "Available Balance: ${availableBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                    case BalanceFetchingErrorState:
                      return Text(
                        "Available Balance: ${availableBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                    default:
                      return Text(
                        "Available Balance: ${availableBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                  }
                },
              ),
              const SizedBox(height: 10),
              BlocConsumer<PortfolioBloc, PortfolioState>(
                bloc: portfolioBloc,
                listenWhen: (previous, current) =>
                    current is PortfolioActionState,
                buildWhen: (previous, current) =>
                    current is! PortfolioActionState,
                listener: (context, state) {},
                builder: (context, state) {
                  int buyedQuantity = 0;
                  switch (state.runtimeType) {
                    case PortfolioFetchingLoadingState:
                      return GlobalWidgets().splashScreen();
                    case PortfolioFetchingSuccessfulState:
                      final successsState =
                          state as PortfolioFetchingSuccessfulState;
                      buyedStocks = successsState.portfolio;
                      for (int i = 0; i < buyedStocks.length; i++) {
                        if (widget.stock.shortName ==
                            buyedStocks[i].stockName) {
                          buyedQuantity = buyedStocks[i].quantityBuyed;
                        }
                      }
                      return Text(
                        "Buyed Quantity: $buyedQuantity",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                    case PortfolioFetchingErrorState:
                      return Text(
                        "Buyed Quantity: $buyedQuantity",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                    default:
                      return Text(
                        "Buyed Quantity: $buyedQuantity",
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      );
                  }
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    buyStock();
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  child: const Text(
                    'Buy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: sellStock,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: const Text(
                    'Sell',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
