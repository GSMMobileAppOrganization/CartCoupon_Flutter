import 'dart:developer';

import 'package:cart_coupon_flutter/controller/data_controller.dart';
import 'package:cart_coupon_flutter/controller/shopping_cart_controller.dart';
import 'package:cart_coupon_flutter/model/shopping_cart_model.dart';
import 'package:flutter/material.dart';

import '../controller/coupon_controller.dart';
import '../model/coupon_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int _selectedCoupon = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await CouponController.coupon();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingCarts = DataController.shoppingCart;
    final coupons = DataController.coupons;

    if (coupons.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final coupon = coupons[_selectedCoupon];

    final total = ShoppingCartController.finalPrice(coupon);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: shoppingCarts.length,
                itemBuilder: (context, index) {
                  final shoppingCart = shoppingCarts[index];
                  return _cartItem(shoppingCart);
                },
              ),
            ),
            _buildBottomSection(coupons, total),
          ],
        ),
      ),
    );
  }

  Widget _cartItem(ShoppingCartModel shoppingCart) {
    return Container(
      color: Colors.grey,
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images${shoppingCart.imageUrl}",
                  height: 80,
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      shoppingCart.name.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${shoppingCart.price.toString()}원 ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ShoppingCartController.minusItem(shoppingCart);
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Color(0xff474545),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        shoppingCart.quantity.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ShoppingCartController.plusItem(shoppingCart);
                          });
                          log(shoppingCart.id.toString());
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          color: Color(0xff474545),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${shoppingCart.price * shoppingCart.quantity} 원",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(List<CouponModel> coupons, int total) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('총 상품 금액'),
                  Text('${ShoppingCartController.totalPrice().toString()} 원'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('쿠폰 선택'),
                  DropdownButton<int>(
                    value: _selectedCoupon,
                    items: List.generate(
                      coupons.length,
                      (index) => DropdownMenuItem<int>(
                        value: index,
                        child: Text(coupons[index].name),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedCoupon = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('총 결제 금액'),
                  Text('${total.toString()} 원'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
