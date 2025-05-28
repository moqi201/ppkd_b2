import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b2/TUgas/AboutPage.dart';
import 'package:ppkd_b2/TUgas/latihan.dart';
import 'package:provider/provider.dart';

import 'theme_provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const Tugas7(), const AboutAppPage()];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
        ],
        color:
            themeProvider.isDarkMode ? Colors.black : const Color(0xff85193C),
        buttonBackgroundColor: const Color(0xff85193C),
        backgroundColor: Colors.transparent,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
