import 'package:flutter/material.dart';
import 'screes/screen1.dart';
import 'screes/screen2.dart';

class bottombar extends StatefulWidget {
  const bottombar({super.key});

  @override
  State<bottombar> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<bottombar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '물품'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: '장바구니'),
        ],
      ),
    );
  }
}
