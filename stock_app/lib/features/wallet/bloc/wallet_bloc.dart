import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stock_app/features/wallet/repo/try_balance_repo.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<BalanceFetchEvent>(balanceFetchEvent);
    on<BalanceIncrementEvent>(balanceIncrementEvent);
    on<BalanceDecrementEvent>(balanceDecrementEvent);
  }
  double balance = 0;

  FutureOr<void> balanceFetchEvent(
      BalanceFetchEvent event, Emitter<WalletState> emit) async {
    emit(BalanceFetchingLoadingState());
    try {
      balance = await TryBalanceRepo().fetchBalance();
      emit(BalanceFetchingSuccessfulState(balance: balance));
    } catch (e) {
      log("Wallet Bloc \n" + e.toString());
      emit(BalanceFetchingErrorState());
    }
  }

  FutureOr<void> balanceIncrementEvent(
      BalanceIncrementEvent event, Emitter<WalletState> emit) {
    balance = balance + event.val;
    emit(BalanceIncrementState());
    TryBalanceRepo().update(balance);
  }

  FutureOr<void> balanceDecrementEvent(
      BalanceDecrementEvent event, Emitter<WalletState> emit) {
    balance = balance - event.val;
    emit(BalanceDecrementState());
    TryBalanceRepo().update(balance);
  }
}
