// ignore_for_file: must_be_immutable

part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

class BalanceFetchEvent extends WalletEvent {}

class BalanceIncrementEvent extends WalletEvent {
  double val;
  BalanceIncrementEvent(this.val);
}

class BalanceDecrementEvent extends WalletEvent {
  double val;
  BalanceDecrementEvent(this.val);
}
