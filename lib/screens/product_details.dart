import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/models/provider/cart_provider.dart';
import 'package:ecommerce_app/models/provider/favorite_provider.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_old_price;
  final product_detail_price;
  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_old_price,
      this.product_detail_price});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavored = false;

  bool isCarted = false;
  String selectedSize = '';
  String selectedColor = '';
  var sizes = ['3XS', 'XXS', 'XS', 'XL', 'XXL', '3XL', 'S', 'M', 'L'];
  var colors = ['Black', 'Gray', 'Red', 'Blue'];
  @override
  void initState() {
    super.initState();
    selectedSize = sizes[0];
    selectedColor = colors[0];
  }

  @override
  Widget build(BuildContext context) {
    final ItemModel arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Home, 'Fashapp'),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                  color: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: arguments.picture,
                    fit: BoxFit.cover,
                  )),
              footer: new Container(
                color: Colors.white,
                child: ListTile(
                  leading: new Text(
                    '${arguments.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          '\$${arguments.old_price}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          '\$${arguments.price}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              getBtn('Size'),
              getBtn('Color'),
              // getBtn('Quntity'),
            ],
          ),
          getSecondRow(arguments),
          Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text('Product details'),
            subtitle: new Text('This page shares my best articles '
                'to read on topics like health, happiness, creativity, '
                'productivity and more. The central question that drives '
                'my work is, “How can we live better?” To answer that question, '
                'I like to write about science-based ways to solve practical problems'),
          ),
          Divider(
            height: 5.0,
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Product name',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  '${arguments.name}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          // new Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
          //       child: new Text(
          //         'Product brand',
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(5.0),
          //       child: new Text(
          //         'Brand X',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //   ],
          // ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Product condition',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  'NEW',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Similar products'),
          ),
          Container(height: 300, child: Products()),
        ],
      ),
    );
  }

  Widget getSecondRow(ItemModel arguments) {
    var bloc = Provider.of<CartProvider>(context, listen: false);
    var cart = bloc.getCart();
    var blocFav = Provider.of<FavoriteProvider>(context, listen: false);
    var favLst = blocFav.getFavorites();
    checkIsExist(cart, arguments.id);
    checkIsFavored(favLst, arguments.id);
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
              onPressed: () {},
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0.2,
              child: new Text('Buy now')),
        ),
        new IconButton(
          icon: Icon(
            isCarted ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
            color: Colors.red,
          ),
          onPressed: () {
            bloc.addRemoveToCart(
              CartItem(
                  ItemModel(
                    id: arguments.id,
                    name: arguments.name,
                    price: arguments.price,
                    old_price: arguments.old_price,
                    category: arguments.category,
                    color: selectedColor,
                    picture: arguments.picture,
                    size: selectedSize,
                  ),
                  1),
            );
            setState(() {
              isCarted = !isCarted;
            });
          },
        ),
        new IconButton(
          icon: Icon(
            isFavored ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            blocFav.addRemoveToFavorites(ItemModel(
              id: arguments.id,
              name: arguments.name,
              price: arguments.price,
              old_price: arguments.old_price,
              category: arguments.category,
              color: selectedColor,
              picture: arguments.picture,
              size: selectedSize,
            ));
            setState(() {
              isFavored = !isFavored;
            });
          },
        ),
      ],
    );
  }

  Widget getBtn(String str) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return showList(str);
              });
        },
        color: Colors.white,
        textColor: Colors.grey,
        elevation: 0.2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new Text('$str'),
            ),
            Expanded(
              child: str == 'Size'
                  ? new Text('$selectedSize')
                  : new Text('$selectedColor'),
            ),
            Expanded(
              child: new Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }

  void checkIsExist(List<CartItem> cart, id) {
    for (var item in cart) {
      if (item.product.id == id) {
        setState(() {
          isCarted = true;
        });
        return;
      }
    }
    setState(() {
      isCarted = false;
    });
  }

  void checkIsFavored(List<ItemModel> fav, id) {
    for (var item in fav) {
      if (item.id == id) {
        setState(() {
          isFavored = true;
        });
        return;
      }
    }
    setState(() {
      isFavored = false;
    });
  }

  Widget showList(String str) {
    switch (str) {
      case 'Size':
        return new AlertDialog(
          title: new Text('$str'),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            child: new ListView.builder(
              itemCount: sizes.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(sizes[index]),
                    onTap: () {
                      setState(() {
                        selectedSize = sizes[index];
                      });
                      Navigator.of(context).pop(true);
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            new MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: new Text('Close'),
            ),
          ],
        );
      case 'Color':
        return new AlertDialog(
          title: new Text('$str'),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            child: new ListView.builder(
              itemCount: colors.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(colors[index]),
                    onTap: () {
                      setState(() {
                        selectedColor = colors[index];
                      });
                      Navigator.of(context).pop(true);
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            new MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: new Text('Close'),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
