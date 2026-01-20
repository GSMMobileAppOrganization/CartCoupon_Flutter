import 'dart:convert';

import 'package:cart_coupon/models/coupon_model.dart';
import 'package:flutter/services.dart';

import 'data_controller.dart';

class CouponController {
  static Future<void> getCouponData() async {
    final String response = await rootBundle.loadString("assets/data.json");
    final data = await jsonDecode(response);
    DataController.couponList = List<CouponModel>.from(
      data['coupons'].map((json) => CouponModel.fromJson(json)).toList(),
    );
  }
}
