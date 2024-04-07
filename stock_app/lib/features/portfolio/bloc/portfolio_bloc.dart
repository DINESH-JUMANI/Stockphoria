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
    on<PortfolioBuyEvent>(portfolioBuyEvent);
    on<PortfolioSellEvent>(portfolioSellEvent);
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

  FutureOr<void> portfolioBuyEvent(
      PortfolioBuyEvent event, Emitter<PortfolioState> emit) async {
    Portfolio portfolioUpdated = event.portfolio;
    bool isPresent = false;
    for (int i = 0; i < portfolio.length; i++) {
      if (event.portfolio.stockName == portfolio[i].stockName) {
        isPresent = true;
        double buyingPrice =
            (event.portfolio.buyingPrice + portfolio[i].buyingPrice) / 2;
        int quantityBuyed =
            (event.portfolio.quantityBuyed + portfolio[i].quantityBuyed);
        portfolioUpdated = Portfolio(
            userId: portfolio[i].userId,
            stockName: event.portfolio.stockName,
            buyingPrice: buyingPrice,
            quantityBuyed: quantityBuyed,
            totalAmount: buyingPrice * quantityBuyed);
      }
    }
    if (isPresent) {
      PortfolioRepo().update(portfolioUpdated);
    }
    if (!isPresent) {
      PortfolioRepo().add(portfolioUpdated);
    }
    emit(PortfolioBuyState());
  }

  FutureOr<void> portfolioSellEvent(
      PortfolioSellEvent event, Emitter<PortfolioState> emit) {
    Portfolio portfolioUpdated = event.portfolio;
    for (int i = 0; i < portfolio.length; i++) {
      if (event.portfolio.stockName == portfolio[i].stockName) {
        double buyingPrice =
            (event.portfolio.buyingPrice + portfolio[i].buyingPrice) / 2;
        int quantityBuyed =
            (portfolio[i].quantityBuyed - event.portfolio.quantityBuyed);
        portfolioUpdated = Portfolio(
            userId: portfolio[i].userId,
            stockName: event.portfolio.stockName,
            buyingPrice: buyingPrice,
            quantityBuyed: quantityBuyed,
            totalAmount: buyingPrice * quantityBuyed);
      }
    }
    if (portfolioUpdated.quantityBuyed == 0)
      PortfolioRepo().remove(portfolioUpdated);
    else
      PortfolioRepo().update(portfolioUpdated);
    emit(PortfolioSellState());
  }
}
