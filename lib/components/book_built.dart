import "package:bookbazaar/apis/book_api.dart";
import "package:bookbazaar/components/route.dart";
import "package:bookbazaar/screen/Books/books_screen.dart";
import "package:flutter/material.dart";

import "../screen/Books/updatebook.dart";
import "error _snackbar.dart";

class BookBuild {
  static List<Widget> buildBook(BuildContext context, List<dynamic> data) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> returnData = [];

    for (var item in data) {
      returnData.add(Container(
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            height: mediaQuery.height * .245,
            width: mediaQuery.width * .4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: Offset(0, 3), // Offset in x and y directions
                ),
              ],
            ),
            child: Image.network(
              "http://192.168.43.192:5000/${item['imagepath']}",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
             Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  onPressed: () {
                    RouterClass.AddScreen(context,UpdateBook(initialBookName: item['bookname'], 
                    initialBookPrice: item['price'], initialBookAuthor: item['author'], initialBookDesc: item['description'], initialBookImage: item['imagepath'], category: item['category'],
                    bid: item["bID"],));
                  },
                  child: Text(
                    "Edit Book",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  onPressed: () async{
                    bool book = await  BookAPI.deletebook(bid: item["bID"]);
                    if(book){
  Navigator.pop(context);
  RouterClass.AddScreen(context, Books());
                    }else{
  InputComponent.showWarningSnackBar(context, "Server Error");
                    }
                  },
                  child: Text(
                    "Remove Book",
                    style: TextStyle(color: Colors.black),

                  ),
                ),
              ),
            ],
          )
        ]),
      ));
    }
    return returnData;
  }

  static Widget buildInfoContainer(BuildContext context, dynamic data) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: mediaQuery.height * .03,
      width: mediaQuery.width * .5,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(2)),
      child: Text(
        "${data}",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
