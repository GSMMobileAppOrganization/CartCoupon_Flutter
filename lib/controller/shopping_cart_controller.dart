import 'package:cart_coupon_flutter/controller/data_controller.dart';
import 'package:cart_coupon_flutter/model/coupon_model.dart';
import 'package:cart_coupon_flutter/model/product_model.dart';
import 'package:cart_coupon_flutter/model/shopping_cart_model.dart';

class ShoppingCartController {
  static void newItem(ProductModel product) {
    final index = DataController.shoppingCart.indexWhere((element) {
      return element.id == product.id;
    });

    if (index == -1) {
      DataController.shoppingCart.add(
        ShoppingCartModel(
          id: product.id,
          imageUrl: product.imageUrl,
          name: product.name,
          price: product.price,
          quantity: 1,
          stock: product.stock,
        ),
      );
    } else {
      final currentItem = DataController.shoppingCart[index];

      if (product.stock > currentItem.quantity) {
        DataController.shoppingCart[index] = ShoppingCartModel(
          id: currentItem.id,
          imageUrl: currentItem.imageUrl,
          name: currentItem.name,
          price: currentItem.price,
          stock: currentItem.stock,
          quantity: currentItem.quantity + 1,
        );
      }
    }
  }

  static void plusItem(ShoppingCartModel shoppingCart) {
    final index = DataController.shoppingCart.indexWhere((element) {
      return element.id == shoppingCart.id;
    });
    final product = DataController.shoppingCart.firstWhere((element) {
      return element.id == shoppingCart.id;
    });

    final currentItem = DataController.shoppingCart[index];

    if (product.stock > currentItem.quantity) {
      DataController.shoppingCart[index] = ShoppingCartModel(
        id: currentItem.id,
        imageUrl: currentItem.imageUrl,
        name: currentItem.name,
        price: currentItem.price,
        stock: currentItem.stock,
        quantity: currentItem.quantity + 1,
      );
    }
  }

  static void minusItem(ShoppingCartModel shoppingCart) {
    final index = DataController.shoppingCart.indexWhere((element) {
      return element.id == shoppingCart.id;
    });

    final currentItem = DataController.shoppingCart[index];

    if (currentItem.quantity > 1) {
      DataController.shoppingCart[index] = ShoppingCartModel(
        id: currentItem.id,
        imageUrl: currentItem.imageUrl,
        name: currentItem.name,
        price: currentItem.price,
        stock: currentItem.stock,
        quantity: currentItem.quantity - 1,
      );
    } else {
      DataController.shoppingCart.removeAt(index);
    }
  }

  static int discount(CouponModel coupon) {
    final discountPrice = totalPrice() * coupon.discountValue ~/ 100;
    if(coupon.maxDiscountPrice < discountPrice){
      return coupon.maxDiscountPrice;
    } else if(totalPrice() < coupon.minOrderPrice){
      return 0;
    } else {
      return discountPrice;
    }
  }

  static int finalPrice(CouponModel coupon) {
    return ShoppingCartController.totalPrice() - discount(coupon);
  }

  static int totalPrice() {
    return DataController.shoppingCart.fold(
      0,
      (previousValue, element) =>
          previousValue + element.quantity * element.price,
    );
  }
}
