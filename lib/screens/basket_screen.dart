import 'dart:core';

import 'package:cart_coupon/controllers/ware_controller.dart';
import 'package:cart_coupon/model/coupon_model.dart';
import 'package:cart_coupon/model/product_model.dart';
import 'package:cart_coupon/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatelessWidget {
  BasketScreen({super.key});

  late WareController controller;

  @override
  Widget build(BuildContext context) {
    controller = context.read<WareController>();

    return Scaffold(
      bottomNavigationBar: BottomBar(context: context),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Builder(
                builder: (context) {
                  final products = context
                      .watch<WareController>()
                      .getMyProducts();

                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        "장바구니에 물품이 없습니다",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final item = products[index];
                      final itemAmount = controller.getProductAmount(item.id);

                      if (itemAmount == 0) {
                        return SizedBox.shrink();
                      }

                      return _Product(ware: item, amount: itemAmount);
                    },
                    itemCount: products.length,
                  );
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              child: FutureBuilder(
                future: controller.loadCoupons(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final coupons = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = coupons[index];
                        return _Coupon(coupon: item);
                      },
                      itemCount: coupons.length,
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Product extends StatelessWidget {
  final ProductModel ware;
  final int amount;

  _Product({required this.ware, required this.amount});

  late WareController controller;

  @override
  Widget build(BuildContext context) {
    controller = context.watch<WareController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ware.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [waresPriceAndStock(), currentPriceAndAmount()],
                  ),

                  Spacer(),

                  button(() {
                    controller.plusItem(ware.id);
                  }, Icons.plus_one),
                  button(() {
                    controller.minusItem(ware.id);
                  }, Icons.exposure_minus_1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(VoidCallback onTap, IconData icon) {
    return IconButton(
      onPressed: onTap,
      style: IconButton.styleFrom(backgroundColor: Colors.red),
      icon: Icon(icon, color: Colors.white),
    );
  }

  Widget waresPriceAndStock() {
    return Row(
      children: [
        Text(
          "재고량 : ${ware.stock}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 16),
          child: SizedBox(width: double.minPositive),
        ),

        Text(
          "단가 : ${ware.price}",
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget currentPriceAndAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("수량 : ${amount}"),
        Row(
          children: [
            Text("소계 : ${amount * ware.price}", style: TextStyle()),

            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 16),
              child: SizedBox(width: double.minPositive),
            ),

            if (controller.isApplyedCoupon(ware.id))
              Text(
                "할인가 : ${controller.applyCouponProducts[ware.id]}",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),

        if (controller.isApplyedCoupon(ware.id))
          Text(
            "쿠폰적용 가격 : ${controller.getProductTotalPrice(ware.id) - controller.applyCouponProducts[ware.id]!}",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}

class _Coupon extends StatelessWidget {
  final CouponModel coupon;

  _Coupon({required this.coupon});

  late WareController controller;

  void select() {
    controller.selectCoupon(coupon.id);
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watch<WareController>();

    return InkWell(
      onTap: select,
      child: Container(
        margin: EdgeInsets.all(6),
        width: 184,
        height: 124,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  coupon.name,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "최소 할인 금액 : ${coupon.minOrderPrice}",
                      style: TextStyle(),
                    ),
                    Text(
                      "최대 할인 금액 : ${coupon.minOrderPrice}",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
