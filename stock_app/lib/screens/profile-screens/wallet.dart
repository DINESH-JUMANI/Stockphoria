import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_app/database-operations/balance_handler.dart';
import 'package:stock_app/providers/balance.dart';

class WalletScreeen extends ConsumerStatefulWidget {
  const WalletScreeen({Key? key}) : super(key: key);

  @override
  ConsumerState<WalletScreeen> createState() {
    return _WalletScreenState();
  }
}

class _WalletScreenState extends ConsumerState<WalletScreeen> {
  final _enteredAmountController = TextEditingController();

  void _deposit() {
    if (_enteredAmountController.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter the amount'),
        ),
      );
      return;
    }
    setState(() {
      ref.read(balanceProvider.notifier).add(_enteredAmountController.text);
      BalanceHandler().add(ref);
      _enteredAmountController.text = "";
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Successfully Deposited'),
        ),
      );
    });
  }

  void _withdraw() {
    if (_enteredAmountController.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Enter the amount'),
        ),
      );
      return;
    }
    setState(() {
      ref.read(balanceProvider.notifier).remove(_enteredAmountController.text);
      BalanceHandler().add(ref);
      _enteredAmountController.text = "";
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Successfully Withdrawn'),
        ),
      );
    });
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
    if (ref.watch(balanceProvider) == 0) {
      BalanceHandler().fetch(ref);
    }
    double amount = ref.watch(balanceProvider);

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
                  onPressed: _withdraw,
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
                  onPressed: _deposit,
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
