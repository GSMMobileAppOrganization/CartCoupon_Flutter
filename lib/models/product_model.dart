class ProductModel {
  final String id;
  final String name;
  final int price;
  final int stock;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      imageUrl: json['imageUrl'],
    );
  }
}
