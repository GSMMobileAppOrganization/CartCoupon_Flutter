class ShoppingCartModel {
  final String id;
  final String name;
  final int price;
  final int stock;
  final String imageUrl;
  final int quantity;

  ShoppingCartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.quantity,
  });
}
