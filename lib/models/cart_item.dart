import 'package:ecommerce_app/models/item_model.dart';

class CartItem {
   ItemModel product;
   int quantity;

  CartItem(this.product, this.quantity);
}