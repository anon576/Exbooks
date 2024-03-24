import 'package:flutter/material.dart';

class UserInputFeild {
Widget inputContainerText(BuildContext context, TextEditingController inputController,
    String hinttext, Icon icon, {bool readOnly = false}) {
  final mediaQuery = MediaQuery.of(context).size;
  return Center(
    child: Container(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      width: mediaQuery.width * .71,
      height: mediaQuery.height * .06,
      decoration: BoxDecoration(
        color: const Color.fromARGB(38, 0, 0, 0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: inputController,
        readOnly: readOnly,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext,
          suffixIcon: icon,
        ),
      ),
    ),
  );
}


  Widget searchContainerText(BuildContext context,
      TextEditingController inputController, String hinttext, Icon icon) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: mediaQuery.width * .76,
          height: mediaQuery.height * .06,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(38, 0, 0, 0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: inputController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              suffixIcon: icon,
            ),
          ),
        ),
        SizedBox(
          width: mediaQuery.width * .01,
        ),
        Container(
          height: mediaQuery.height * .06,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black,
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list_outlined),
            onPressed: () {
              print('Filter button pressed');
            },
            iconSize: mediaQuery.height * .04,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget buttonContainer(BuildContext context, String hintText,
      Future<void> Function() onPressed, bool isLoading) {
    final mediaQuery = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: mediaQuery.width * .71,
        height: mediaQuery.height * .06,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  hintText,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }

 
  static List<Widget> categoryContainer(
      BuildContext context, String image, List categoryName) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
    for (var item in categoryName) {
      data.add(Container(
        margin: EdgeInsets.fromLTRB(25, 10, 0, 10),
        height: mediaQuery.height * 0.2,
        width: mediaQuery.width * 0.88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors
              .white, // Set a background color to see if the container is visible
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover, // Adjust the image fit as needed
              ),
              Positioned(
                bottom: 10,
                right: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return data;
  }


static List<Widget> addressContainer(
      BuildContext context, List addresss) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
    if(addresss.isEmpty){

      data.add( Expanded(child: Center(
                    child: Text('No addresses found'),
                  )) );
      return data;
    }
    for (var item in addresss) {
      data.add(Container(
  margin: EdgeInsets.fromLTRB(25, 10, 0, 10),
  width: mediaQuery.width * 0.88,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${item["country"]}, ${item['state']}, ${item['city']}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "${item['location']} - ${item['pin']}",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    ),
  ),
      ));
      
    }
    return data;
  }


}
