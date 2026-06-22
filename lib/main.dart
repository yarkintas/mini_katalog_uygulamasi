import 'package:flutter/material.dart';

import 'controllers/cart_controller.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatefulWidget {
  const MiniCatalogApp({super.key});

  @override
  State<MiniCatalogApp> createState() => _MiniCatalogAppState();
}

class _MiniCatalogAppState extends State<MiniCatalogApp> {
  final CartController _cart = CartController();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF155E63),
          primary: const Color(0xFF155E63),
          secondary: const Color(0xFFC35B3C),
          tertiary: const Color(0xFFE7B85A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F3EE),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF5F3EE),
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        chipTheme: const ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(cart: _cart),
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailScreen.routeName) {
          final product = settings.arguments as Product;

          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) =>
                ProductDetailScreen(product: product, cart: _cart),
          );
        }

        if (settings.name == CartScreen.routeName) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => CartScreen(cart: _cart),
          );
        }

        if (settings.name == CheckoutScreen.routeName) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (context) => CheckoutScreen(cart: _cart),
          );
        }

        return null;
      },
    );
  }
}
