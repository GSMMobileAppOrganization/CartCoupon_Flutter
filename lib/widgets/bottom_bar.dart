import 'package:cart_coupon/screens/basket_screen.dart';
import 'package:cart_coupon/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final BuildContext context;

  const BottomBar({super.key, required this.context});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: BoxBorder.all(width: 1.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: button(
              () {
                Navigator.pushAndRemoveUntil(
                  widget.context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                  (_) => false,
                );
              },
              "거래품 목록",
              Icons.noise_aware_outlined,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: VerticalDivider(thickness: 1.8),
          ),

          Flexible(
            child: button(
              () {
                print("장바구니");
                Navigator.pushAndRemoveUntil(
                  widget.context,
                  MaterialPageRoute(builder: (context) => BasketScreen()),
                  (_) => false,
                );
              },
              "거래품",
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
    );
  }

  Widget button(VoidCallback onTap, String subText, IconData icon) {
    Color color = Colors.grey.shade500;
    double size = 64;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.2),
            child: Icon(icon, color: color),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  subText,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
