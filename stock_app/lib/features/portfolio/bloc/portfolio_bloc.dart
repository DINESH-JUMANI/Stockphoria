import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/portfolio/model/portfolio.dart';
import 'package:stock_app/features/portfolio/repo/portfolio_repo.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(PortfolioInitial()) {
    on<PortfolioFetchEvent>(portfolioFetchEvent);
    on<PortfolioAddEvent>(portfolioAddEvent);
    on<PortfolioRemoveEvent>(portfolioRemoveEvent);
  }

  List<Portfolio> portfolio = [];

  FutureOr<void> portfolioFetchEvent(
      PortfolioFetchEvent event, Emitter<PortfolioState> emit) async {
    emit(PortfolioFetchingLoadingState());
    try {
      portfolio = await PortfolioRepo().fetchPortfolio();
      emit(PortfolioFetchingSuccessfulState(portfolio: portfolio));
    } catch (e) {
      log("portfolio bloc----" + e.toString());
      emit(PortfolioFetchingErrorState());
    }
  }

  FutureOr<void> portfolioAddEvent(
      PortfolioAddEvent event, Emitter<PortfolioState> emit) {
    bool isPresent = false;
    for (int i = 0; i < portfolio.length; i++) {
      if (portfolio[i].stockName == event.portfolio.stockName) {
        portfolio[i] = event.portfolio;
        isPresent = true;
      }
    }
    if (!isPresent) portfolio.add(event.portfolio);
    emit(PortfolioAddState());
  }

  FutureOr<void> portfolioRemoveEvent(
      PortfolioRemoveEvent event, Emitter<PortfolioState> emit) {
    for (int i = 0; i < portfolio.length; i++) {
      if (portfolio[i].stockName == event.portfolio.stockName) {
        portfolio[i] = event.portfolio;
      }
    }
    emit(PortfolioRemoveState());
  }
}
