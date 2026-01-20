class CartModel {
  final String name;
  final String imageUrl;
  final int price;
  final int stock;
  int quantity;

  CartModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.stock,
  });
}
