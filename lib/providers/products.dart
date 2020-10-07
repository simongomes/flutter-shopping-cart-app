import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier {
  final String authToken;

  Products(this.authToken, this._items);

  List<Product> _items = []; //DUMMY_PRODUCTS;
  
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

  Future<void> fetchAndSetProduct() async {
    final url = 'https://flutter-shop-app-b3619.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData != null) {
        extractedData.forEach((key, product) {
          loadedProducts.add(Product(
            id: key,
            title: product['title'],
            description: product['description'],
            price: product["price"],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite'],
          ));
        });
        _items = loadedProducts;
        notifyListeners();
      }

    } catch (exception) {
      print("Simon: " + exception.toString());
      throw exception;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://flutter-shop-app-b3619.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(url, body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),);

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();

    } catch(exception) {
      print(exception);
      throw exception;
    }

  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if(productIndex >= 0) {
      final url = 'https://flutter-shop-app-b3619.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
          url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl' : newProduct.imageUrl,
        }),
      );
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-shop-app-b3619.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if(response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}