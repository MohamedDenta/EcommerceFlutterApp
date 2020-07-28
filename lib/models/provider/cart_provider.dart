import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> cart_products = [];
  double totalPrice = 0;
  CartProvider() {
    var docs = Firestore.instance.collection('cart').getDocuments();
    docs.then((onValue) {
      for (var item in onValue.documents) {
        cart_products.add(CartItem(
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
          item['quantity'],
        ));
      }
    });
    calculatePrice();
  }
  List<CartItem> getCart() {
    return cart_products;
  }

  addRemoveToCart(CartItem item) async {
    if (item != null) {
      var index = -1;
      for (int i = 0; i < cart_products.length; ++i) {
        var t = cart_products[i];
        if (item.product.id == t.product.id) {
          index = i;
          break;
        }
      }

      // var index = cart_products
      if (index == -1) {
        cart_products.add(item);
        Firestore.instance
            .collection('cart')
            .document(item.product.id)
            .setData({
          'id': item.product.id,
          'name': item.product.name,
          'url': item.product.picture,
          'price': item.product.price,
          'old_price': item.product.old_price,
          'size': item.product.size,
          'category': item.product.category,
          'color': item.product.color,
          'quantity': item.quantity,
        });
      } else {
        var deletedItem = cart_products.removeAt(index);
        var docs = await Firestore.instance.collection('cart').getDocuments();
        DocumentSnapshot temp;
        for (var d in docs.documents) {
          if (deletedItem.product.id == d.data['id']) {
            temp = d;
            break;
          }
        }
        Firestore.instance
            .collection('cart')
            .document(temp.documentID)
            .delete();
      }
      calculatePrice();
      notifyListeners();
    }
  }

  updateQuantity(String id, int quantity) {
    Firestore.instance
        .collection('cart')
        .document(id)
        .setData({'quantity': quantity}, merge: true);
        calculatePrice();
    notifyListeners();
  }

  // removeFromCart(Single_cart_product item) {
  //   var b = cart_products.remove(item);
  //   b ? print('deleted .. ') : print('failed to delete');
  //   notifyListeners();
  // }
  void calculatePrice() {
    totalPrice = 0;
    for (var item in cart_products) {
      totalPrice += (item.quantity * double.parse(item.product.price));
    }
    notifyListeners();
  }
}
