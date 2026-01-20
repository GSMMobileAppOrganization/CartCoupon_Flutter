import 'package:cart_coupon/controller/data_controller.dart';
import 'package:cart_coupon/models/cart_model.dart';
import 'package:cart_coupon/models/product_model.dart';

class CartController {
  static void addCartData(ProductModel product) async {
    int i = DataController.cartList.indexWhere(
      (e) => e.name == product.name,
    );
    if (i == -1) {
      DataController.cartList.add(
        CartModel(
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          stock: product.stock,
          quantity: 1,
        ),
      );
    } else {
      DataController.cartList[i].quantity =
          (DataController.cartList[i].quantity + 1).clamp(0, product.stock);
    }
  }

  static void addCartQuantity(int index) {
    DataController.cartList[index].quantity =
        (DataController.cartList[index].quantity + 1).clamp(
          0,
          DataController.cartList[index].stock,
        );
  }

  static void removeCartQuantity(int index) {
    if (DataController.cartList[index].quantity == 1) {
      DataController.cartList.removeAt(index);
    } else {
      DataController.cartList[index].quantity =
          (DataController.cartList[index].quantity - 1).clamp(
            0,
            DataController.cartList[index].stock,
          );
    }
  }

  static int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < DataController.cartList.length; i++) {
      total +=
          DataController.cartList[i].price *
          DataController.cartList[i].quantity;
    }
    return total;
  }
}
