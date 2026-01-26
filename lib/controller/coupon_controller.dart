import 'dart:convert';

import 'package:cart_coupon_flutter/controller/data_controller.dart';
import 'package:cart_coupon_flutter/model/coupon_model.dart';
import 'package:flutter/services.dart';

class CouponController {
  static Future<void> coupon() async {
    final String response = await rootBundle.loadString('lib/data.json');
    final data = await json.decode(response);

    List couponList = data['coupons'];

    DataController.coupons = couponList
        .map((e) => CouponModel.fromJson(e))
        .toList();
  }
}
