import 'package:bookbazaar/screen/product_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'route.dart';

class Products {
  static Widget buildHomeScreen(BuildContext context,
      List<dynamic> carsoulProduct, List<dynamic> listProduct) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> carsoulList = [];
    List<Widget> contanerList = [];

    for (var item in carsoulProduct) {
      carsoulList.add(GestureDetector(
        onTap: () {
          // Handle button tap here
          print('Container tapped!');
        },
        child: Container(
          height: mediaQuery.height * 0.23,
          width: mediaQuery.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Offset in x and y directions
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(20), // Set the border radius here
            child: Image.network(
              item['image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ));
    }
    Widget carsoul = Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: CarouselSlider(
        items: carsoulList,
        options: CarouselOptions(
          height: 180.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
    contanerList.add(carsoul);
    for (var i = 0; i < listProduct.length; i += 2) {
      contanerList.add(Container(
        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBookContainer(context, listProduct[i]["image"],
                listProduct[i]['title'], listProduct[i]["price"]),
            SizedBox(width: mediaQuery.width * .04),
            buildBookContainer(context, listProduct[i + 1]["image"],
                listProduct[i + 1]['title'], listProduct[i + 1]["price"])
          ],
        ),
      ));
    }
    return Column(
      children: contanerList,
    );
  }

  static Widget buildBookContainer(
      context, String image, String title, dynamic price) {
    final mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          ProductPageclass product = ProductPageclass(name: title, imageUrl: image, price: price);
           RouterClass.AddScreen(context,ProductPage(product:product));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Offset in x and y directions
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mediaQuery.height * 0.23,
                width: mediaQuery.height * 0.18,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(7), // Set the border radius here
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                height: mediaQuery.height * 0.06,
                width: mediaQuery.height * 0.18,
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2)),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                height: mediaQuery.height * 0.03,
                width: mediaQuery.height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2)),
                child: Text(
                  "Price : $price",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
