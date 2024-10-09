import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/presentation/search/search_screen.dart';
import 'package:movies_app/features/main_layout/presentation/watch_list/watch_list_screen.dart';

import 'categories/browse_categories_screen.dart';
import 'home/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> screens = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const BrowseCategoriesScreen(),
    const WatchListScreen(),
  ];

  final List<String> _title = [
    "Movies",
    "Search",
    "Genres",
    "Watch List",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 25,
        centerTitle: true,
        title: Text(_title[currentIndex]),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFF1A1A1A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Color(0xFF1A1A1A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Genres',
              backgroundColor: Color(0xFF1A1A1A),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Watchlist',
              backgroundColor: Color(0xFF1A1A1A),
            ),
          ],
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
