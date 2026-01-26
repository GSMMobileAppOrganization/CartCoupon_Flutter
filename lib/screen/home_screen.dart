import 'package:cart_coupon_flutter/screen/product_screen.dart';
import 'package:cart_coupon_flutter/screen/shopping_cart_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final screen = [
    ProductScreen(),
    ShoppingCartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: navigationBar(),
    );
  }

  Widget navigationBar() => BottomNavigationBar(
    backgroundColor: Colors.white,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.content_paste), label: '상품 목록'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '장바구니'),
    ],

    type: BottomNavigationBarType.fixed,
    onTap: (value) {
      currentIndex = value;
      setState(() {});
    },
    currentIndex: currentIndex,
  );
}
