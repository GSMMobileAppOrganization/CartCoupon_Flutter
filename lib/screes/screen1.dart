import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/product.dart';
import '../controller.dart';

Future<List<Product>> loadProducts() async {
  final jsonString = await rootBundle.loadString('assets/data.json');
  final data = json.decode(jsonString);
  final List list = data['products'];
  return list.map((e) => Product.fromJson(e)).toList();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cartController = CartController();
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = loadProducts();
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cartController,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
              title: const Text(
            '쇼핑몰',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          body: FutureBuilder<List<Product>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());
              final products = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Image.asset(
                        product.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 60),
                      ),
                      title: Text(product.name),
                      subtitle:
                          Text('${product.price}원\n재고: ${product.stock}개'),
                      isThreeLine: true,
                      trailing: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          cartController.addProduct(product);
                          showMessage('${product.name}을(를) 담았습니다.');
                        },
                        child: const Text('담기'),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
