// ignore_for_file: must_be_immutable

part of 'portfolio_bloc.dart';

@immutable
sealed class PortfolioEvent {}

class PortfolioFetchEvent extends PortfolioEvent {}

class PortfolioAddEvent extends PortfolioEvent {
  Portfolio portfolio;
  PortfolioAddEvent(this.portfolio);
}

class PortfolioRemoveEvent extends PortfolioEvent {
  Portfolio portfolio;
  PortfolioRemoveEvent(this.portfolio);
}
