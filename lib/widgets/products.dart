import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<ItemModel> product_list = List();
  //[
  // {
  //   "name": "Blazer1",
  //   "picture": "assets/images/products/blazer1.jpeg",
  //   "old_price": 100,
  //   "price": 90,
  // },
  // {
  //   "name": "Blazer2",
  //   "picture": "assets/images/products/blazer2.jpeg",
  //   "old_price": 120,
  //   "price": 105,
  // },
  // {
  //   "name": "Dress1",
  //   "picture": "assets/images/products/dress1.jpeg",
  //   "old_price": 99,
  //   "price": 90,
  // },
  // {
  //   "name": "Hills1",
  //   "picture": "assets/images/products/hills1.jpeg",
  //   "old_price": 150,
  //   "price": 135,
  // },
  // {
  //   "name": "Hills2",
  //   "picture": "assets/images/products/hills2.jpeg",
  //   "old_price": 100,
  //   "price": 90,
  // },
  // {
  //   "name": "Pants1",
  //   "picture": "assets/images/products/pants1.jpg",
  //   "old_price": 100,
  //   "price": 90,
  // },
  // {
  //   "name": "Pants2",
  //   "picture": "assets/images/products/pants2.jpeg",
  //   "old_price": 200,
  //   "price": 190,
  // },
  // {
  //   "name": "Shoe1",
  //   "picture": "assets/images/products/shoe1.jpg",
  //   "old_price": 160,
  //   "price": 145,
  // },
  // {
  //   "name": "skt1",
  //   "picture": "assets/images/products/skt1.jpeg",
  //   "old_price": 100,
  //   "price": 90,
  // },
  // {
  //   "name": "skt2",
  //   "picture": "assets/images/products/skt2.jpeg",
  //   "old_price": 100,
  //   "price": 90,
  // },
  // ];

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('products').getDocuments().then((onValue) {
      final docs = onValue.documents;
      for (var item in docs) {
        setState(() {
          product_list.add(ItemModel(
            id: item['id'],
            category: item['category'],
            name: item['name'],
            price: item['price'],
            old_price: item['old_price'],
            picture: item['url'],
            size: item['size'],
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return product_list.length == 0
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            itemCount: product_list.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SingleProd(
                prod_category: product_list[index].category,
                prod_id: product_list[index].id,
                prod_name: product_list[index].name,
                prod_picture: product_list[index].picture,
                prod_old_price: product_list[index].old_price,
                prod_price: product_list[index].price,
              );
            });
  }
}

class SingleProd extends StatelessWidget {
  final prod_id;
  final prod_category;
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  const SingleProd(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price,
      this.prod_id,
      this.prod_category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Hero(
        tag: Text(prod_name),
        child: Material(
          child: InkWell(
            onDoubleTap: () {
              print('${this.prod_name}');
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: getItemWidget(),
                ),
              );
            },
            onTap: () {
              var p = ItemModel(
                id: prod_id,
                name: prod_name,
                old_price: prod_old_price,
                picture: prod_picture,
                price: prod_price,
                category: prod_category,
              );
              Navigator.pushNamed(context, '/productdetails', arguments: p);
            },
            child: getItemWidget(),
          ),
        ),
      ),
    );
  }

  getItemWidget() {
    return GridTile(
      footer: Container(
        color: Colors.white,
        child: new Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  prod_name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                '\$$prod_price',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: prod_picture,
      ),
    );
  }
}
