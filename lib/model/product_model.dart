class ProductModel {
  String id;
  String name;
  int price;
  int stock;
  String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  static ProductModel from(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      stock: json["stock"],
      imageUrl: json["imageUrl"],
    );
  }

  /*  "id": "p006",
      "name": "게이밍 마우스패드 XL",
      "price": 12900,
      "stock": 30,
      "imageUrl": "/mousepad.png"
    */
}
