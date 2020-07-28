import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<ItemModel> items = List();
  CategoryProvider() {
    Firestore.instance.collection('products').getDocuments().then((onValue) {
      final docs = onValue.documents;
      for (var item in docs) {
        items.add(ItemModel(
          id: item['id'],
          category: item['category'],
          name: item['name'],
          price: item['price'],
          old_price: item['old_price'],
          picture: item['url'],
          size: item['size'],
        ));
      }
    });
  }
}
