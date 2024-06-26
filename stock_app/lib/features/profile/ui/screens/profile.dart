import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stock_app/features/auth/ui/screens/login_screen.dart';
import 'package:stock_app/features/portfolio/ui/portfolio_screen.dart';
import 'package:stock_app/features/profile/ui/screens/about_us.dart';
import 'package:stock_app/features/profile/ui/screens/support.dart';
import 'package:stock_app/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:stock_app/features/wallet/ui/screens/wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _user = FirebaseAuth.instance;
  void _logOut() async {
    await _user.signOut();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged Out Successfully'),
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  String username = "Profile";
  String imageUrl = "";
  Future _getUser() async {
    final user = _user.currentUser!;
    await user.reload();
    final userData =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
    username = userData.data()!['username'];
    imageUrl = userData.data()!['profile_pic'];
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const PortfolioScreen()));
    } else if (index == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const WalletScreen()));
    } else if (index == 2) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const SupportScreen()));
    } else if (index == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const AboutUsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(),
                  ),
                );
              },
              child: Card(
                color: Colors.grey.shade300,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FutureBuilder(
                      future: _getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SpinKitCircle(
                            size: 50,
                            color: Colors.black,
                          );
                        }
                        return Column(
                          children: [
                            CircleAvatar(
                              maxRadius: 35,
                              backgroundColor: Colors.white,
                              foregroundImage: NetworkImage(imageUrl),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.edit),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
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
