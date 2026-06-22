import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString('assets/data/products.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final data = jsonMap['data'] as List<dynamic>;

    return data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
