import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
      header: Container(
        color: Colors.black45,
        padding: EdgeInsets.all(10),
        child: Text("\$${product.price}", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id,);
          },
          child: Image.network(product.imageUrl, fit: BoxFit.cover,),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          leading: Consumer<Product>(
    builder: (_, product, child) => IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border
            ),
            onPressed: () {
              product.toggleFavorite();
            },
          ),),
          title: Text(product.title, textAlign: TextAlign.center,),
          trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart),
              onPressed: (){},
            ),
          ),
        ),
    );
  }
}
