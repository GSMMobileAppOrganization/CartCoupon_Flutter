import 'package:cart_coupon/screen/base_screen.dart';
import 'package:cart_coupon/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        )
      ),
      home: BaseScreen(),
    ),
  );
}
