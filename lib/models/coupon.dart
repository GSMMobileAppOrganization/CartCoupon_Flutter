class Coupon {
  final String id;
  final String name;
  final String discountType;
  final int discountValue;
  final int minOrderPrice;
  final int? maxDiscountPrice;
  final bool isActive;

  Coupon({
    required this.id,
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.minOrderPrice,
    this.maxDiscountPrice,
    required this.isActive,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      name: json['name'],
      discountType: json['discountType'],
      discountValue: json['discountValue'],
      minOrderPrice: json['minOrderPrice'],
      maxDiscountPrice: json['maxDiscountPrice'],
      isActive: json['isActive'],
    );
  }
}
