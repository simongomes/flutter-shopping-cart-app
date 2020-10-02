
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "./orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _isLoading = true;
    Provider.of<Orders>(context, listen: false).fetchAndSetOrder().then((_) {_isLoading = false;});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
        itemBuilder: (_, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
