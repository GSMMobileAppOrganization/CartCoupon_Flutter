class CouponModel {
  String id;
  String name;
  String discountType;
  int discountValue;
  int minOrderPrice;
  int? maxDiscountPrice;
  bool isActive;

  CouponModel({
    required this.id,
    required this.name,
    required this.discountType,
    required this.discountValue,
    required this.minOrderPrice,
    required this.maxDiscountPrice,
    required this.isActive,
  });

  static CouponModel from(Map<String, dynamic> json) {
    return CouponModel(
      id: json["id"],
      name: json["name"],
      discountType: json["discountType"],
      discountValue: json["discountValue"],
      minOrderPrice: json["minOrderPrice"],
      maxDiscountPrice: json["maxDiscountPrice"],
      isActive: json["isActive"],
    );
  }
}

/*
      "id": "c015",
      "name": "주말특가 15% 할인",
      "discountType": "PERCENT",
      "discountValue": 15,
      "minOrderPrice": 30000,
      "maxDiscountPrice": 10000,
      "isActive": true
    */

/*{
      "id": "c000",
      "name": "쿠폰 없음",
      "discountType": "PERCENT",
      "discountValue": 0,
      "minOrderPrice": 0,
      "maxDiscountPrice": null,
      "isActive": true
    },*/
