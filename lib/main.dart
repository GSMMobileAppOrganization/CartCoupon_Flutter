import 'package:cart_coupon/controllers/ware_controller.dart';
import 'package:cart_coupon/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WareController(),
      child: MaterialApp(
        home: ProductListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
}

class Global {
  static final imagePath = "assets/images";
  static final jsonPath = "assets/data.json";
}
