part of 'portfolio_bloc.dart';

@immutable
sealed class PortfolioState {}

final class PortfolioInitial extends PortfolioState {}

abstract class PortfolioActionState extends PortfolioState {}

class PortfolioFetchingLoadingState extends PortfolioState {}

class PortfolioFetchingErrorState extends PortfolioState {}

class PortfolioFetchingSuccessfulState extends PortfolioState {
  final List<Portfolio> portfolio;
  PortfolioFetchingSuccessfulState({required this.portfolio});
}

class PortfolioAddState extends PortfolioActionState {}

class PortfolioRemoveState extends PortfolioActionState {}
