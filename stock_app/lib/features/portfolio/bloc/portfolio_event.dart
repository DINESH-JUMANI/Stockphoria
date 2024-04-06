// ignore_for_file: must_be_immutable

part of 'portfolio_bloc.dart';

@immutable
sealed class PortfolioEvent {}

class PortfolioFetchEvent extends PortfolioEvent {}

class PortfolioBuyEvent extends PortfolioEvent {
  Portfolio portfolio;
  PortfolioBuyEvent(this.portfolio);
}

class PortfolioSellEvent extends PortfolioEvent {
  Portfolio portfolio;
  PortfolioSellEvent(this.portfolio);
}
