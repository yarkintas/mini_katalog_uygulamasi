import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  double get unitPrice => parsePrice(product.price);

  double get lineTotal => unitPrice * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}

class CartController extends ChangeNotifier {
  final Map<int, CartItem> _items = <int, CartItem>{};

  List<CartItem> get items => _items.values.toList(growable: false);

  bool get isEmpty => _items.isEmpty;

  int get totalQuantity {
    return _items.values.fold<int>(0, (total, item) => total + item.quantity);
  }

  double get subtotal {
    return _items.values.fold<double>(
      0,
      (total, item) => total + item.lineTotal,
    );
  }

  void add(Product product) {
    final current = _items[product.id];

    if (current == null) {
      _items[product.id] = CartItem(product: product, quantity: 1);
    } else {
      _items[product.id] = current.copyWith(quantity: current.quantity + 1);
    }

    notifyListeners();
  }

  void increment(Product product) {
    add(product);
  }

  void decrement(Product product) {
    final current = _items[product.id];

    if (current == null) {
      return;
    }

    if (current.quantity <= 1) {
      _items.remove(product.id);
    } else {
      _items[product.id] = current.copyWith(quantity: current.quantity - 1);
    }

    notifyListeners();
  }

  void remove(Product product) {
    if (_items.remove(product.id) != null) {
      notifyListeners();
    }
  }

  void clear() {
    if (_items.isNotEmpty) {
      _items.clear();
      notifyListeners();
    }
  }
}

double parsePrice(String value) {
  final numeric = value.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(numeric) ?? 0;
}

String formatPrice(double value) {
  final cents = ((value - value.floor()) * 100).round();
  final whole = value.floor().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < whole.length; i += 1) {
    if (i > 0 && (whole.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(whole[i]);
  }

  if (cents == 0) {
    return '\$${buffer.toString()}';
  }

  return '\$${buffer.toString()}.${cents.toString().padLeft(2, '0')}';
}
