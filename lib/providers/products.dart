import 'package:flutter/material.dart';
import '../data/dummy_products.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;
  
  var _showFavoritesOnly = false;

  List<Product> get items {
//    if(_showFavoritesOnly) {
//      return _items.where((product) => product.isFavorite).toList();
//    }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

//  void showFavoritesOnly() {
//    _showFavoritesOnly = true;
//    notifyListeners();
//  }
//
//  void showAll() {
//    _showFavoritesOnly = false;
//    notifyListeners();
//  }

  void addProduct(value) {
//    _items.add(value);
    notifyListeners();
  }
}