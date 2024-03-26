import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_app/features/stock/bloc/stock_bloc.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/stock/ui/screens/buy_sell.dart';
import 'package:stock_app/features/stock/ui/widgets/list_stocks.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({Key? key}) : super(key: key);

  @override
  _StockssState createState() => _StockssState();
}

class _StockssState extends State<StocksScreen> {
  final StockBloc stockBloc = StockBloc();
  void onClick(StockModel stock) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return BuySell(
        stock: stock,
      );
    }));
  }

  @override
  void initState() {
    stockBloc.add(StockFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Stocks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<StockBloc, StockState>(
        bloc: stockBloc,
        listenWhen: (previous, current) => current is StockActionState,
        buildWhen: (previous, current) => current is! StockActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case StockFetchingLoadingState:
              return const Center(
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.black,
                ),
              );

            case StockFetchingSuccessfulState:
              final successState = state as StockFetchingSuccessfulState;
              return ListStocks(stocks: successState.stocks);
            default:
              return Text('');
          }
        },
      ),
    );
  }
}
