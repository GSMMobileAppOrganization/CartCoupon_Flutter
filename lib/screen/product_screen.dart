import 'dart:developer';

import 'package:cart_coupon_flutter/controller/data_controller.dart';
import 'package:cart_coupon_flutter/controller/product_controller.dart';
import 'package:cart_coupon_flutter/controller/shopping_cart_controller.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ProductController.product();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = DataController.products;

    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _listItem(product);
        },
      ),
    );
  }

  Widget _listItem(dynamic product) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20,),
      child: Row(
        children: [
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images${product.imageUrl}',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text("${product.price}원"),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${product.stock}개 남음",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    log("${product.name} 담기");
                    ShoppingCartController.newItem(product);
                    log(DataController.shoppingCart.length.toString());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width,
                    height: 30,
                    color: Colors.blueAccent,
                    child: Text(
                      '담기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
