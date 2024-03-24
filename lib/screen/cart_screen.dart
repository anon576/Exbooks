import "package:bookbazaar/components/cart_buill.dart";
import "package:bookbazaar/components/custom_appbar.dart";
import "package:flutter/material.dart";

import "../apis/cart_api.dart";
import "../components/shimmer_effect.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


 List cartList = [];
  bool isCartLoaded = false;

 Future<void> fetchCart() async {
  List<dynamic> newListCategory = await CartAPI.getAllCart();
  if (mounted) { // Check if the widget is still mounted
    if (newListCategory.isNotEmpty) {
      setState(() {
        cartList.addAll(newListCategory);
        isCartLoaded = true;
      });
    }
  }
}


  List<Widget> screen() {
    if (isCartLoaded) {
      return CartBuild.buldCart(context, cartList);
    } else {
      return ShimmerEffect.cartShimmer(context);
    }
  }

  @override
  void initState() {
    fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final mediaQuery = MediaQuery.of(context).size;
    return Scaffold( 
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: screen()
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                 
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: mediaQuery.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Implement add to cart functionality
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      height: mediaQuery.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.yellow,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Implement add to cart functionality
                        },
                        child: Text(
                          'Buy Now',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}