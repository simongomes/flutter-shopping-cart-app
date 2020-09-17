import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: ProductsGrid()
    );
  }
}


