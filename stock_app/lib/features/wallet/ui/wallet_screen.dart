import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Wallet'),
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        bloc: walletBloc,
        listenWhen: (previous, current) => current is WalletActionState,
        buildWhen: (previous, current) => current is! WalletActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case BalanceFetchingLoadingState:
              return const Center(
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.black,
                ),
              );
            case BalanceFetchingSuccessfulState:
              final successState = state as BalanceFetchingSuccessfulState;
              double amount = successState.balance;
              return Padding(
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
                              Text(
                                '₹${amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.black45),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
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
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white),
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            walletBloc.add(BalanceDecrementEvent(
                                double.parse(_enteredAmountController.text)));
                            walletBloc.add(BalanceFetchEvent());
                          },
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
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            walletBloc.add(BalanceIncrementEvent(
                                double.parse(_enteredAmountController.text)));
                            walletBloc.add(BalanceFetchEvent());
                          },
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
              );
            default:
              return Center(
                child: Text('Something wrong'),
              );
          }
        },
      ),
    );
  }
}
