import 'package:cart_coupon/controllers/ware_controller.dart';
import 'package:cart_coupon/main.dart';
import 'package:cart_coupon/model/product_model.dart';
import 'package:cart_coupon/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  late WareController controller;

  @override
  Widget build(BuildContext context) {
    controller = context.read<WareController>();
    return Scaffold(
      bottomNavigationBar: BottomBar(context: context),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder<List<ProductModel>>(
              future: controller.loadProducts(),
              builder: (context, snapshot) {

                print(snapshot.data);

                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _Product(product: item),
                      );
                    },
                    itemCount: products.length,
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Product extends StatelessWidget {
  final ProductModel product;

  _Product({required this.product});

  late WareController controller;

  void addItem(String id) {
    controller.plusItem(id);
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watch<WareController>();

    print(Global.imagePath + product.imageUrl);

    return Container(
      padding: EdgeInsets.all(8),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(border: BoxBorder.all(width: 2)),
            child: Image.asset(
              "${Global.imagePath}${product.imageUrl}",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('가격 : ${product.price}', style: TextStyle()),
                      Text('수량 : ${product.stock}', style: TextStyle()),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          addItem(product.id);
                        },
                        child: Text(
                          "장바구니에 담기",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
