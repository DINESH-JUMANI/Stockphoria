import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/widgets/global_widgets.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/stock/ui/widgets/list_stocks.dart';
import 'package:stock_app/features/watchlist/bloc/watchlist_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final WatchlistBloc watchlistBloc = WatchlistBloc();
  List<StockModel> listOfWishListStocks = [];

  @override
  void initState() {
    watchlistBloc.add(WatchlistFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Watchlist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<WatchlistBloc, WatchlistState>(
        bloc: watchlistBloc,
        listenWhen: (previous, current) => current is WatchlistActionState,
        buildWhen: (previous, current) => current is! WatchlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WatchlistFetchingLoadingState:
              return GlobalWidgets().splashScreen();
            case WatchlistFetchingSuccessfulState:
              final successState = state as WatchlistFetchingSuccessfulState;
              listOfWishListStocks = successState.watchlistedStocks;
              if (listOfWishListStocks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 130,
                        height: 150,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Add Stocks in Watchlist!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListStocks(
                  stocks: listOfWishListStocks,
                );
              }
            default:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 130,
                      height: 150,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Add Stocks in Watchlist!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
