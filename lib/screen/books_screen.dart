import "package:bookbazaar/components/route.dart";
import "package:bookbazaar/screen/add_book_screen.dart";
import "package:flutter/material.dart";

import "../apis/book_api.dart";
import "../components/book_built.dart";
import "../components/custom_appbar.dart";
import "../components/shimmer_effect.dart";

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {



 List bookList = [];
  bool isbookLoaded = false;

 Future<void> fetchCart() async {
  List<dynamic> newListCategory = await BookAPI.getAllBooks();
  if (mounted) { // Check if the widget is still mounted
    if (newListCategory.isNotEmpty) {
      setState(() {
        bookList.addAll(newListCategory);
        isbookLoaded = true;
      });
    }
  }
}


  List<Widget> screen() {
    if (isbookLoaded) {
      return BookBuild.buildBook(context, bookList);
    } else {
      return ShimmerEffect.yourBooksShimmer(context);
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
      appBar: CustomAppBar.screenAppbar("Your Books"),
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
                          RouterClass.AddScreen(context, AddNewBook());
                        },
                        child: Text(
                          'Add Book',
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