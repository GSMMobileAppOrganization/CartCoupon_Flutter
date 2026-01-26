import 'package:flutter/material.dart';
import 'models/product.dart';
import 'models/cart_item.dart';
import 'models/coupon.dart';

class CartController extends ChangeNotifier {
  static final CartController _instance = CartController._internal();

  factory CartController() => _instance;

  CartController._internal();

  final List<CartItem> items = [];
  Coupon? selectedCoupon;

  void addProduct(Product product) {
    final index = items.indexWhere((e) => e.cartitem.id == product.id);
    if (index != -1) {
      if (items[index].size < product.stock) {
        items[index].size += 1;
      }
    } else {
      items.add(CartItem(cartitem: product));
    }
    notifyListeners();
  }

  void increase(Product product) {
    final index = items.indexWhere((e) => e.cartitem.id == product.id);
    if (index != -1 && items[index].size < product.stock) {
      items[index].size += 1;
      notifyListeners();
    }
  }

  void decrease(Product product) {
    final index = items.indexWhere((e) => e.cartitem.id == product.id);
    if (index != -1) {
      if (items[index].size > 1) {
        items[index].size -= 1;
      } else {
        items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void selectCoupon(Coupon? coupon) {
    selectedCoupon = coupon;
    notifyListeners();
  }

  int totalPrice() => items.fold(0, (sum, item) => sum + item.total());

  int discountPrice() {
    if (selectedCoupon == null || selectedCoupon!.minOrderPrice > totalPrice())
      return 0;
    int discount = totalPrice() * selectedCoupon!.discountValue ~/ 100;
    if (selectedCoupon!.maxDiscountPrice != null &&
        discount > selectedCoupon!.maxDiscountPrice!) {
      discount = selectedCoupon!.maxDiscountPrice!;
    }
    return discount;
  }

  int finalPrice() => totalPrice() - discountPrice();
}
