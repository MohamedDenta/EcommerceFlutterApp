import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/provider/cart_provider.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/cart_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartProvider>(context, listen: false);
    // bloc.calculatePrice();
    totalPrice = bloc.totalPrice;
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Cart, "cart"),
      body: Cart_products(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text('Total:'),
                subtitle: new Text('\$$totalPrice'),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: ()  {
                  if(totalPrice>0){
                  //   StripeSource.addSource().then((String token){
                  //   PaymentService().addCard(token);
                  // });
                  // final s= SnackBar(content: Text('total price is $totalPrice'),); 
                    // Scaffold.of(context).showSnackBar(s);
                    Navigator.of(context).pop(true);
                  }else {
                    // final s= SnackBar(content: Text('total price is $totalPrice'),); 
                    // Scaffold.of(context).showSnackBar(s);
                    showDialog(context: context , child: AlertDialog(
                      content: Text('total price is $totalPrice'),
                    ));
                  }
                  
                },
                child: new Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
