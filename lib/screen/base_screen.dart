import 'package:cart_coupon/controller/coupon_controller.dart';
import 'package:cart_coupon/controller/product_controller.dart';
import 'package:cart_coupon/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

import 'cart_list_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool isLoading = true;

  int currentIndex = 0;

  List pages = [
    ProductListScreen(),
    CartListScreen(),
  ];

  List title = [
    '상품 목록 화면',
    '장바구니 화면',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ProductController.getProductsData();
      await CouponController.getCouponData();
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title[currentIndex]),
          centerTitle: true,
        ),
        body: pages[currentIndex],
        bottomNavigationBar: customBottomNavigationBar(),
      );
    }
  }

  Widget customBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) {
        currentIndex = value;
        setState(() {});
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.sell_rounded), label: '상품 목록'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: '장바구니',
        ),
      ],
    );
  }
}
