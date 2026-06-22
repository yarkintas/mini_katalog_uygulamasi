import 'package:flutter/material.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../widgets/cart_badge.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cart,
  });

  static const routeName = '/product-detail';

  final Product product;
  final CartController cart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Urun detayi'),
        actions: [CartBadge(cart: cart, onPressed: () => _openCart(context))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
        children: [
          Container(
            height: 310,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(34),
                    child: Hero(
                      tag: 'product-image-${product.id}',
                      child: Image.asset(product.image, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  top: 14,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFF182423),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        product.price,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product.name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            product.tagline,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          _SectionBlock(
            title: 'Aciklama',
            child: Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                color: const Color(0xFF313B39),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionBlock(
            title: 'Teknik ozellikler',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.specs.entries
                  .map((entry) {
                    return Chip(
                      avatar: const Icon(Icons.check_circle_outline, size: 18),
                      label: Text('${entry.key}: ${entry.value}'),
                    );
                  })
                  .toList(growable: false),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: FilledButton.icon(
          onPressed: () => _addToCart(context),
          icon: const Icon(Icons.add_shopping_cart_outlined),
          label: const Text('Sepete ekle'),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    cart.add(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Sepet',
          onPressed: () => _openCart(context),
        ),
      ),
    );
  }

  void _openCart(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
