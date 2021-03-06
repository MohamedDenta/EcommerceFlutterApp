import 'package:ecommerce_app/models/provider/cart_provider.dart';
import 'package:ecommerce_app/models/provider/connectivity.dart';
import 'package:ecommerce_app/models/provider/favorite_provider.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:ecommerce_app/screens/account_screen.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/category_screen.dart';
import 'package:ecommerce_app/screens/favorites_screen.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/screens/settings_screen.dart';
import 'package:ecommerce_app/screens/yours_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/provider/category_provider.dart';
import 'screens/addressbook_screen.dart';
import 'screens/countrylang_screen.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectivityService(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // theme:  myThemeData,
      theme: myThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/productdetails": (context) => ProductDetails(),
        "/cart": (context) => Cart(),
        "/login": (context) => LoginWithGoogle(),
        "/account": (context) => AccountScreen(),
        "/yours": (context) => YourScreen(),
        "/addressbook": (context) => AddressBookScreen(),
        "/countrylang": (context) => CountryLangScreen(),
        "/settings": (context) => SettingScreen(),
        "/category": (context) => CategoryScreen(),
        "/favorites": (context) => FavoriteScreen(),
      },
    );
  }
}
