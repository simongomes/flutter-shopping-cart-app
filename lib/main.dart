import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Make the necessary providers available for the app
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (_, auth, previousProducts) => Products(
              auth.token,
              previousProducts == null ? [] : previousProducts.items
          ),
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (_, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders
          ),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) {
        return MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() :AuthScreen(),
          routes: {
            ProductDetailScreen.routeName:  (_) => ProductDetailScreen(),
            CartScreen.routeName:           (_) => CartScreen(),
            OrdersScreen.routeName:         (_) => OrdersScreen(),
            UserProductsScreen.routeName:   (_) => UserProductsScreen(),
            EditProductScreen.routeName:    (_) => EditProductScreen(),
          },
        );
      },),
    );
  }
}