import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "About Platform",
      "Privacy Policy",
      "Terms of Use",
      "Risk Disclosure",
      "Listing/Delisting Policy",
      "Refund/Cancellation Policy",
      "Beta Testing Policy",
    ];
    List<String> content = [
      "Know more about application",
      "How we colect, use, and protect your data",
      "The terms governing use of Platform",
      "Outlining the risks associated with services/products available on Platform",
      "Explain the framework of listing/delisting a token on this Platform",
      "Explains the circumstances, conditions, and timelines where returns, exchanges, and refunds are processed by Application",
      "Explains the rules, terms, and conditions you agree with to participate in our Platform/'s early access and beta testing programs",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Support'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12)),
        child: ListView.separated(
          itemCount: titles.length,
          separatorBuilder: (ctx, index) {
            return Divider(
              color: Colors.grey.shade500,
            );
          },
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    content[index],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
