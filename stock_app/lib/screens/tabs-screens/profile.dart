import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_app/screens/auth-screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  String username = "Profile";
  Future _getUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    username = userData.data()!['username'];
  }

  List<IconData> icons = [
    Icons.file_copy,
    Icons.account_balance_wallet,
    Icons.support_agent,
    Icons.error_outline,
  ];

  List<String> headline = [
    "Portfolio",
    "Wallet",
    "Customer Support 24x7",
    "About Us"
  ];

  List<String> content = [
    "View your Portfolio",
    "Add Money",
    "FAQs, Contact Us",
    "About, Terms, Privacy Policy"
  ];

  void onClick(int index) {
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: Colors.grey.shade300,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      FutureBuilder(
                        future: _getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const SpinKitCircle(
                              size: 50,
                              color: Colors.black,
                            );
                          }
                          return Text(
                            username,
                            style: const TextStyle(fontSize: 30),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Card(
                color: Colors.grey.shade300,
                child: ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Colors.black26,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      onTap: () => onClick(index),
                      title: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 30,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            child: Icon(
                              icons[index],
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headline[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                content[index],
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: _logOut,
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
