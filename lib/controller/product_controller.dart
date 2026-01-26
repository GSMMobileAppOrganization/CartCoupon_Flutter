import 'dart:convert';

import 'package:cart_coupon_flutter/controller/data_controller.dart';
import 'package:cart_coupon_flutter/model/product_model.dart';
import 'package:flutter/services.dart';

class ProductController {
  static Future<void> product() async {
    final String response = await rootBundle.loadString('lib/data.json');
    final data = await json.decode(response);

    List productList = data['products'];

    DataController.products = productList
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
