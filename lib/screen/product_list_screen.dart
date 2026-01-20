import 'package:cart_coupon/controller/cart_controller.dart';
import 'package:cart_coupon/controller/data_controller.dart';
import 'package:cart_coupon/controller/product_controller.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ProductController.getProductsData();
      isLoading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: DataController.productList.length,
      itemBuilder: (context, index) => listItem(index),
    );
  }

  Widget listItem(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images${DataController.productList[index].imageUrl}',
                width: MediaQuery.sizeOf(context).width / 2,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    DataController.productList[index].name,
                    style: TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                  Text(
                    '가격: ${DataController.productList[index].price}원',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    '제고: ${DataController.productList[index].stock}',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      CartController.addCartData(
                        DataController.productList[index],
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: .circular(4)),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      '담기',
                      style: TextStyle(color: Colors.white, fontWeight: .bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
