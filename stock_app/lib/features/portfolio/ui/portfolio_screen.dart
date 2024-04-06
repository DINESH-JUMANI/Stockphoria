import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/global_widgets.dart';
import 'package:stock_app/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() {
    return _PortfolioScreenState();
  }
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  PortfolioBloc portfolioBloc = PortfolioBloc();
  @override
  void initState() {
    portfolioBloc.add(PortfolioFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Portfolio'),
      ),
      body: BlocConsumer(
        bloc: portfolioBloc,
        listenWhen: (previous, current) => current is PortfolioActionState,
        buildWhen: (previous, current) => current is! PortfolioActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PortfolioFetchingLoadingState:
              return GlobalWidgets().splashScreen();
            case PortfolioFetchingSuccessfulState:
              final successState = state as PortfolioFetchingSuccessfulState;
              final portfolioStocks = successState.portfolio;
              List<Portfolio> listOfBuyedStocks = [];
              for (int i = 0; i < portfolioStocks.length; i++) {
                if (portfolioStocks[i].quantityBuyed != 0)
                  listOfBuyedStocks.add(portfolioStocks[i]);
              }
              if (listOfBuyedStocks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/stocks.png',
                        width: 200,
                        height: 180,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No Stocks Found!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: listOfBuyedStocks.length,
                  itemBuilder: (context, index) {
                    String stockName = listOfBuyedStocks[index].stockName;
                    double buyingPrice = listOfBuyedStocks[index].buyingPrice;
                    int quantity = listOfBuyedStocks[index].quantityBuyed;
                    double totalAmount = listOfBuyedStocks[index].totalAmount;
                    return Card(
                      margin: const EdgeInsets.all(12),
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stockName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quantity: ${quantity.toString()}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  totalAmount.toStringAsFixed(2),
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'LTP: ${buyingPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            default:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/stocks.png',
                      width: 200,
                      height: 180,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No Stocks Found!',
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
