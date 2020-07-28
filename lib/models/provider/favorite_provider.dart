import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  List<ItemModel> favoriteProducts = [];
  FavoriteProvider() {
    var docs = Firestore.instance.collection('favorites').getDocuments();
    docs.then((onValue) {
      for (var item in onValue.documents) {
        favoriteProducts.add(
          ItemModel(
            id: item['id'],
            name: item['name'],
            picture: item['url'],
            price: item['price'],
            old_price: item['old_price'],
            size: item['size'],
            category: item['category'],
            color: item['color'],
          ),
        );
      }
    });
  }
  List<ItemModel> getFavorites() {
    return favoriteProducts;
  }

  addRemoveToFavorites(ItemModel item) async {
    if (item != null) {
      var index = -1;
      for (int i = 0; i < favoriteProducts.length; ++i) {
        var t = favoriteProducts[i];
        if (item.id == t.id) {
          index = i;
          break;
        }
      }

      // var index = cart_products
      if (index == -1) {
        favoriteProducts.add(item);
        Firestore.instance.collection('favorites').document(item.id).setData({
          'id': item.id,
          'name': item.name,
          'url': item.picture,
          'price': item.price,
          'old_price': item.old_price,
          'size': item.size,
          'category': item.category,
          'color': item.color,
        });
      } else {
        ItemModel deletedItem = favoriteProducts.removeAt(index);
        var docs =
            await Firestore.instance.collection('favorites').getDocuments();
        DocumentSnapshot temp ;
        for (var d in docs.documents) {
          if (deletedItem.id == d.data['id']) {
            temp = d;
            
            break;
          }
        }
        Firestore.instance
            .collection('favorites')
            .document(temp.documentID)
            .delete();
      }
      // calculatePrice();
      notifyListeners();
    }
  }

  // updateQuantity(String id, int quantity) {
  //   Firestore.instance
  //       .collection('cart')
  //       .document(id)
  //       .setData({'quantity': quantity}, merge: true);
  //       calculatePrice();
  //   notifyListeners();
  // }

  // removeFromCart(Single_cart_product item) {
  //   var b = cart_products.remove(item);
  //   b ? print('deleted .. ') : print('failed to delete');
  //   notifyListeners();
  // }
  // void calculatePrice() {
  //   totalPrice = 0;
  //   for (var item in cart_products) {
  //     totalPrice += (item.quantity * double.parse(item.product.price));
  //   }
  //   notifyListeners();
  // }
}
