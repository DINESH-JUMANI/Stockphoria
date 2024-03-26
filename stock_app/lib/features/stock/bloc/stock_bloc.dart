import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/stock/model/stock_model.dart';
import 'package:stock_app/features/stock/repos/stock_repo.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<StockFetchEvent>(stockFetchEvent);
  }

  FutureOr<void> stockFetchEvent(
      StockFetchEvent event, Emitter<StockState> emit) async {
    emit(StockFetchingLoadingState());
    try {
      List<StockModel> stocks = await StockRepo().fetchStocks();
      emit(StockFetchingSuccessfulState(stocks: stocks));
    } catch (e) {
      log(e.toString());
      emit(StockFetchingErrorState());
    }
  }
}
