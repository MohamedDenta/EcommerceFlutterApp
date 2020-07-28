import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:ecommerce_app/models/provider/category_provider.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ItemModel> items = List();
  @override
  Widget build(BuildContext context) {
    String arguments = ModalRoute.of(context).settings.arguments;
    var bloc = Provider.of<CategoryProvider>(context,listen: false);
    setState(() {
      items = bloc.items;
    });
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Category, arguments),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, int index) {
            return buildItem(index);
          }),
    );
  }

  Widget buildItem(int index) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: CachedNetworkImage(
            imageUrl: items[index].picture,
            fit: BoxFit.fitWidth,
            
          ),
        ),
      ),
    );
  }
}
