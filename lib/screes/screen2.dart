import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../controller.dart';
import '../models/coupon.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = CartController();
  List<Coupon> coupons = [];

  String formatPrice(int price) => price.toString();

  @override
  void initState() {
    super.initState();
    _loadCoupons();
  }

  Future<void> _loadCoupons() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List list = jsonMap['coupons'];
    setState(() {
      coupons = list.map((e) => Coupon.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cartController,
      builder: (context, child) {
        final items = cartController.items;

        return Scaffold(
          appBar: AppBar(
              title: const Text(
            '장바구니',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          body: items.isEmpty
              ? const Center(child: Text('장바구니가 비어있습니다.'))
              : ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    ...items.map((item) => Card(
                          child: ListTile(
                            title: Text(item.cartitem.name),
                            subtitle: Text('${formatPrice(item.total())}원'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () =>
                                        cartController.decrease(item.cartitem)),
                                Text('${item.size}'),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () =>
                                        cartController.increase(item.cartitem)),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(height: 20),
                    Text('쿠폰 선택',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ...coupons.map((coupon) => RadioListTile<Coupon>(
                          title: Text(coupon.name),
                          value: coupon,
                          groupValue: cartController.selectedCoupon,
                          onChanged: (val) => cartController.selectCoupon(val),
                        )),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('총 상품 금액'),
                                Text(
                                    '${formatPrice(cartController.totalPrice())}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('할인 금액'),
                                Text(
                                  '- ${formatPrice(cartController.discountPrice())}',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '최종 결제 금액',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ${formatPrice(cartController.finalPrice())}',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(height: 20),
                    FilledButton(
                      style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Colors.blue),
                      onPressed: cartController.items.isEmpty
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${formatPrice(cartController.finalPrice())}원으로 결제가 완료되었습니다.')),
                              );
                            },
                      child: Text('결제하기'),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
