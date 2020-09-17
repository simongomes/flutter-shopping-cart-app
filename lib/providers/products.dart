import 'package:flutter/material.dart';
import '../data/dummy_products.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items];
  }
  
  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct(value) {
//    _items.add(value);
    notifyListeners();
  }
}