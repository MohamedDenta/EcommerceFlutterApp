import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<CachedNetworkImage> urls = List();
  @override
  void initState() {
    super.initState();
    fetchCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return urls.length == 0
        ? Container(
          width: 100,
          height: 100,
          child: Center(child:CircularProgressIndicator() ,)) 
        : Container(
            child: new Carousel(
              boxFit: BoxFit.contain,
              images: urls,
              autoplay: true,
              //animationCurve: Curves.fastOutSlowIn,
              //animationDuration: Duration(milliseconds: 1000),
              dotSize: 4.0,
              indicatorBgPadding: 2.0,
            ),
          );
  }

  Future<void> fetchCarousel() async {
    urls.clear();
    var promoRef = Firestore.instance.collection('promo').reference();
    var allDocs = await promoRef.getDocuments();
    print("FFFFF    ${allDocs.documents.length}");
    for (var item in allDocs.documents) {
      if (item.documentID == 'lg') {
        continue;
      }
      setState(() {
        urls.add(
          CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: 100,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          fit: BoxFit.cover,
          imageUrl: item['url'],
          errorWidget: (context, url, error) => Icon(Icons.error),

        ));
      });
    }
  }

  getCarousel() {
    //fetchCarousel();
    return Container(
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: urls,
        // [
        //   AssetImage('assets/images/c1.jpg'),
        //   AssetImage('assets/images/m1.jpeg'),
        //   AssetImage('assets/images/w1.jpeg'),
        //   AssetImage('assets/images/m2.jpg'),
        // ],
        autoplay: false,
        //animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );
  }
}
