import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/common/global_widgets.dart';
import 'package:stock_app/features/wallet/bloc/wallet_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WalletScreenState();
  }
}

class _WalletScreenState extends State<WalletScreen> {
  final _enteredAmountController = TextEditingController();
  final WalletBloc walletBloc = WalletBloc();
  double amount = 0;
  @override
  void dispose() {
    _enteredAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    walletBloc.add(BalanceFetchEvent());
    super.initState();
  }

  void _clicked_1000() {
    setState(() {
      _enteredAmountController.text = "\t\t\t1000";
    });
  }

  void _clicked_5000() {
    setState(() {
      _enteredAmountController.text = "\t\t\t5000";
    });
  }

  void withdraw() {
    if (_enteredAmountController.text.isEmpty) {
      GlobalWidgets().showSnackBar(context, Colors.red, 'Enter Amount');
      return;
    }
    double enteredAmount = double.parse(_enteredAmountController.text);
    if (amount <= enteredAmount) {
      GlobalWidgets().showSnackBar(context, Colors.red, 'Insufficient Balance');
      return;
    }
    walletBloc.add(BalanceDecrementEvent(enteredAmount));
    walletBloc.add(BalanceFetchEvent());
    GlobalWidgets()
        .showSnackBar(context, Colors.green, 'Successfully Withdrawn');
  }

  void deposit() {
    if (_enteredAmountController.text.isEmpty) {
      GlobalWidgets().showSnackBar(context, Colors.red, 'Enter Amount');
      return;
    }
    walletBloc.add(
        BalanceIncrementEvent(double.parse(_enteredAmountController.text)));
    walletBloc.add(BalanceFetchEvent());
    GlobalWidgets()
        .showSnackBar(context, Colors.green, 'Successfully Deposited');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade300),
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.wallet,
                          size: 45,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      BlocConsumer<WalletBloc, WalletState>(
                        bloc: walletBloc,
                        listenWhen: (previous, current) =>
                            current is WalletActionState,
                        buildWhen: (previous, current) =>
                            current is! WalletActionState,
                        listener: (context, state) {},
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case BalanceFetchingLoadingState:
                              return GlobalWidgets().splashScreen();
                            case BalanceFetchingSuccessfulState:
                              final successState =
                                  state as BalanceFetchingSuccessfulState;
                              amount = successState.balance;
                              if (amount < 0) amount = 0;
                              return Text(
                                '₹${amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              );
                            default:
                              return Text(
                                '₹${amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              );
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          controller: _enteredAmountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "\t\t\tEnter Amount (INR)",
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black45),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                            ),
                            onPressed: _clicked_1000,
                            child: const Text(
                              '₹1000',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                            ),
                            onPressed: _clicked_5000,
                            child: const Text(
                              '₹5000',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: withdraw,
                  child: const Text(
                    'WITHDRAW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: deposit,
                  child: const Text(
                    'DEPOSIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
