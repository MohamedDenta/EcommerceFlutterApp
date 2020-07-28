import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart_products extends StatefulWidget {
  Cart_products({Key key}) : super(key: key);
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  List<CartItem> products_on_the_cart = [];
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartProvider>(context,listen: false);
    products_on_the_cart = bloc.cart_products;
    if (products_on_the_cart.length == 0) {
      return Center(
        child: Text('No items in your cart'),
      );
    }
    return new ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(itemModel: products_on_the_cart[index]);

          // return new SingleCartProduct(
          //   cart_prod_name: products_on_the_cart[index]['name'],
          //   cart_prod_color: products_on_the_cart[index]['color'],
          //   cart_prod_qty: products_on_the_cart[index]['quantity'],
          //   cart_prod_size: products_on_the_cart[index]['size'],
          //   cart_prod_price: products_on_the_cart[index]['price'],
          //   cart_prod_picture: products_on_the_cart[index]['picture'],
          // );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final CartItem itemModel;

  const SingleCartProduct({
    Key key,
    this.itemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartProvider>(context,listen: false);
    return GestureDetector(
      // onHorizontalDragUpdate: (d){
        
      // },
      onHorizontalDragEnd: (d) {
        bloc.addRemoveToCart(itemModel);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CachedNetworkImage(
                    imageUrl: itemModel.product.picture,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Text(itemModel.product.name),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: new Text('Size: '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('${itemModel.product.size}',
                            style: TextStyle(color: Colors.red)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8.0, 8.0, 8.0),
                        child: new Text('Color: '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: new Text('${itemModel.product.color}',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      new Text('\$${itemModel.product.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                    icon: Icon(Icons.arrow_drop_up),
                    onPressed: () {
                      bloc.updateQuantity(
                          itemModel.product.id, itemModel.quantity++);
                    },
                  ),
                  Text(
                    '${itemModel.quantity}',
                  ),
                  new IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      if (itemModel.quantity == 1) {
                        return;
                      }
                      bloc.updateQuantity(
                          itemModel.product.id, itemModel.quantity--);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
