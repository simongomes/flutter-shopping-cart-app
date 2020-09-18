import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/orders_screen.dart';
import './screens/cart_screen.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Make the necessary providers available for the app
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName:  (_) => ProductDetailScreen(),
          CartScreen.routeName:           (_) => CartScreen(),
          OrdersScreen.routeName:         (_) => OrdersScreen(),
        },
      ),
    );
  }
}