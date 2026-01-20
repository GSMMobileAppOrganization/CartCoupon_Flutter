import 'package:cart_coupon/controller/cart_controller.dart';
import 'package:cart_coupon/controller/data_controller.dart';
import 'package:flutter/material.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  int discount = 0;
  var discountPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    int total = CartController.getTotalPrice();

    return Column(
      children: [
        ClipRRect(
          borderRadius: .circular(64),
          child: Container(
            padding: .all(12),
            height: MediaQuery.sizeOf(context).height / 2,
            child: ListView.builder(
              itemCount: DataController.cartList.length,
              itemBuilder: (context, index) {
                return cartItem(index);
              },
            ),
          ),
        ),
        DropdownButton(
          dropdownColor: Colors.white,
          value: discount,
          items: DataController.couponList
              .map(
                (e) => DropdownMenuItem(
                  enabled: total >= e.minOrderPrice,
                  value: e.discountValue,
                  child: Text(
                    e.name,
                    style: TextStyle(
                      color: total >= e.minOrderPrice
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            discount = value ?? 0;
            int i = DataController.couponList.indexWhere(
              (e) => e.discountValue == discount,
            );
            discountPrice = (total * (discount / 100));
            discountPrice = double.parse(
              '${discountPrice.clamp(0, DataController.couponList[i].maxDiscountPrice)}',
            );
            setState(() {});
          },
        ),
        Text('총 상품 금액: $total원'),
        Text(
          '할인 금액:${discountPrice.round()}원',
        ),
        Text('최종 결제 금액:${total - discountPrice.round()}원'),
      ],
    );
  }

  Widget cartItem(int index) {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsetsGeometry.all(12),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: .circular(12),
                child: Image.asset(
                  'assets/images${DataController.cartList[index].imageUrl}',
                  height: 64,
                  width: 64,
                ),
              ),
              SizedBox(width: 4),
              Text(
                DataController.cartList[index].name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: .bold,
                ),
              ),
              Spacer(),
              Text('단가: ${DataController.cartList[index].price}원'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      CartController.removeCartQuantity(index);
                      setState(() {});
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Container(
                    height: 32,
                    width: 32,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('${DataController.cartList[index].quantity}'),
                  ),
                  IconButton(
                    onPressed: () {
                      CartController.addCartQuantity(index);
                      setState(() {});
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),

              Text(
                '소계: ${DataController.cartList[index].price * DataController.cartList[index].quantity}원',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
