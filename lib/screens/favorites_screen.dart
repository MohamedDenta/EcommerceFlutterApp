import 'package:ecommerce_app/widgets/favorite_products.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'),
        centerTitle: true,
      ),
      body: Container(
        child: FavoriteProducts(),
      ),
    );
  }
}