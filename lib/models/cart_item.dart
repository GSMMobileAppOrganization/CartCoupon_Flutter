import 'product.dart';

class CartItem {
  final Product cartitem;
  int size;

  CartItem({required this.cartitem, this.size = 1});

  int total() {
    return cartitem.price * size;
  }
}
