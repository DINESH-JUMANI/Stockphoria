import 'package:flutter/material.dart';
import 'package:stock_app/features/news/ui/screens/news_screen.dart';
import 'package:stock_app/features/profile/ui/screens/profile.dart';
import 'package:stock_app/features/stock/ui/screens/stock_screen.dart';
import 'package:stock_app/features/watchlist/ui/screens/watchlist_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;
  final screens = [
    const WatchlistScreen(),
    const StocksScreen(),
    const NewsScreen(),
    const ProfileScreen(),
  ];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.remove_red_eye_sharp),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.stacked_bar_chart),
              label: 'Stocks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Profile',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
