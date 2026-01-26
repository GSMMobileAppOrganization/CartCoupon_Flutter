class CouponModel {
  final String id;
  final String name;
  final String discountType;
  final int discountValue;
  final int minOrderPrice;
  final int maxDiscountPrice;
  final bool isActive;

  CouponModel({
    required this.id,
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.minOrderPrice,
    required this.maxDiscountPrice,
    required this.isActive,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json["id"],
      name: json["name"],
      discountType: json["discountType"],
      discountValue: json["discountValue"],
      minOrderPrice: json["minOrderPrice"],
      maxDiscountPrice: json["maxDiscountPrice"] ?? 0,
      isActive: json["isActive"],
    );
  }
}
