import 'dart:convert';

import 'package:cart_coupon/main.dart';
import 'package:cart_coupon/model/coupon_model.dart';
import 'package:cart_coupon/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class WareController extends ChangeNotifier {
  late Map<String, int> _basketProducts = {};

  List<ProductModel> _productCache = [];
  List<CouponModel> _couponCache = [];

  late CouponModel selectingCoupon;
  Map<String, int> applyCouponProducts = {};

  void plusItem(String id) {
    if (!_basketProducts.containsKey(id)) {
      _basketProducts[id] = 1;
    } else if (_basketProducts[id]! >= _verifyTotalProductMount(id)) {
      return;
    } else {
      _basketProducts[id] = _basketProducts[id]! + 1;
    }
    print("id : ${id}, amount : ${_basketProducts[id]}");

    notifyListeners();
  }

  void minusItem(String id) {
    if (_basketProducts.containsKey(id)) {
      if (_basketProducts[id]! <= 1) {
        _basketProducts.remove(id);
      } else {
        _basketProducts[id] = _basketProducts[id]! - 1;
      }
      notifyListeners();
    }
  }

  int getProductAmount(String id) {
    if (!_basketProducts.containsKey(id)) {
      return 0;
    }
    return _basketProducts[id]!;
  }

  int getProductTotalPrice(String id) {
    final amount = getProductAmount(id);

    if (amount == 0) {
      return 0;
    }

    final price = getMyProducts().where((pro) => pro.id == id).first.price;

    return price * amount;
  }

  bool isApplyedCoupon(String id) {
    return applyCouponProducts.containsKey(id);
  }

  List<ProductModel> getMyProducts() {
    List<ProductModel> myList = [];

    print(_basketProducts);

    _basketProducts.forEach((key, _) {
      final product = _productCache.where((pro) => pro.id == key).firstOrNull;
      if (product != null) {
        myList.add(product);
      }
    });

    return myList;
  }

  List<CouponModel> getMyCoupon() {
    return _couponCache;
  }

  int _verifyTotalProductMount(String id) {
    return _productCache.where((pro) => pro.id == id).first.stock;
  }

  void selectCoupon(String id) {
    final tempCoupon = _couponCache.where((cou) => cou.id == id).firstOrNull;

    if (tempCoupon != null) {
      selectingCoupon = tempCoupon;

      print(selectingCoupon.id);

      applyCouponProducts = applyCoupon(selectingCoupon);

      print(applyCouponProducts.values);

      notifyListeners();
    }
  }

  Map<String, int> applyCoupon(CouponModel coupon) {
    Map<String, int> tempList = {};

    if (coupon.isActive) {
      getMyProducts().forEach((pro) {
        final totalPrice = getProductTotalPrice(pro.id) ?? 0;

        if (totalPrice >= coupon.minOrderPrice) {
          final discount = totalPrice * coupon.discountValue;

          tempList.addAll({
            pro.id: discount > (coupon.maxDiscountPrice ?? discount + 1)
                ? coupon.maxDiscountPrice!
                : discount,
          });
        }
        ;
      });
    }
    return tempList;
  }
}

extension Load on WareController {
  Future<List<ProductModel>> loadProducts() async {
    final json = await rootBundle.loadString(Global.jsonPath);
    final products = jsonDecode(json)['products'] as List;

    print(products);

    _productCache = products.map((pro) => ProductModel.from(pro)).toList();

    print(_productCache);

    return _productCache;
  }

  Future<List<CouponModel>> loadCoupons() async {
    final json = await rootBundle.loadString(Global.jsonPath);
    final products = jsonDecode(json)['coupons'] as List;

    _couponCache = products.map((pro) => CouponModel.from(pro)).toList();

    print(_couponCache);

    return _couponCache;
  }
}
