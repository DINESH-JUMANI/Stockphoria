part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

abstract class WalletActionState extends WalletState {}

class BalanceFetchingLoadingState extends WalletState {}

class BalanceFetchingErrorState extends WalletState {}

class BalanceFetchingSuccessfulState extends WalletState {
  final double balance;
  BalanceFetchingSuccessfulState({required this.balance});
}

class BalanceIncrementState extends WalletActionState {}

class BalanceDecrementState extends WalletActionState {}
