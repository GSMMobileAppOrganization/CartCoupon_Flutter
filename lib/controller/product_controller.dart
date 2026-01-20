import 'dart:convert';

import 'package:cart_coupon/controller/data_controller.dart';
import 'package:cart_coupon/models/product_model.dart';
import 'package:flutter/services.dart';

class ProductController {
  static Future<void> getProductsData() async {
    final String response = await rootBundle.loadString("assets/data.json");
    final data = await jsonDecode(response);
    DataController.productList = List<ProductModel>.from(
      data['products'].map((json) => ProductModel.fromJson(json)).toList(),
    );
  }
}
