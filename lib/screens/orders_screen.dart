
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "./orders";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (_, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
