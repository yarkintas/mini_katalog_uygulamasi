import 'package:flutter/material.dart';

import '../controllers/cart_controller.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.cart, this.onPressed});

  final CartController cart;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cart,
      builder: (context, child) {
        return IconButton(
          tooltip: 'Sepet',
          onPressed: onPressed,
          icon: Badge(
            isLabelVisible: cart.totalQuantity > 0,
            label: Text('${cart.totalQuantity}'),
            child: child,
          ),
        );
      },
      child: const Icon(Icons.shopping_bag_outlined),
    );
  }
}
