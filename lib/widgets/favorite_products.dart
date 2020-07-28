import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/models/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProducts extends StatefulWidget {
  FavoriteProducts({Key key}) : super(key: key);
  @override
  _FavoriteProductsState createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  List<ItemModel> favoriteproducts = [];
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<FavoriteProvider>(context, listen: false);
    favoriteproducts = bloc.favoriteProducts;
    if (favoriteproducts.length == 0) {
      return Center(
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite_border , size: 40,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No items in your favorite list'),
            ),
          ],
        ),
      );
    }
    return new ListView.builder(
        itemCount: favoriteproducts.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(itemModel: favoriteproducts[index]);

          // return new SingleCartProduct(
          //   cart_prod_name: favoriteproducts[index]['name'],
          //   cart_prod_color: favoriteproducts[index]['color'],
          //   cart_prod_qty: favoriteproducts[index]['quantity'],
          //   cart_prod_size: favoriteproducts[index]['size'],
          //   cart_prod_price: favoriteproducts[index]['price'],
          //   cart_prod_picture: favoriteproducts[index]['picture'],
          // );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final ItemModel itemModel;

  const SingleCartProduct({
    Key key,
    this.itemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<FavoriteProvider>(context, listen: false);
    return GestureDetector(
      // onHorizontalDragUpdate: (d){

      // },
      onHorizontalDragEnd: (d) {
        bloc.addRemoveToFavorites(itemModel);
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
                    imageUrl: itemModel.picture,
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
                      new Text(itemModel.name),
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
                        child: new Text('${itemModel.size}',
                            style: TextStyle(color: Colors.red)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8.0, 8.0, 8.0),
                        child: new Text('Color: '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: new Text('${itemModel.color}',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      new Text('\$${itemModel.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
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
