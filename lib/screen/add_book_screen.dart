import 'dart:convert';
import 'dart:typed_data';
import 'package:bookbazaar/apis/book_api.dart';
import 'package:bookbazaar/components/route.dart';
import 'package:bookbazaar/components/user_input_feild.dart';
import 'package:bookbazaar/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/custom_appbar.dart';
import '../components/error _snackbar.dart';

class AddNewBook extends StatefulWidget {
  final String? initialBookName;
  final String? initialBookPrice;
  final String? initialBookAuthor;
  final String? initialBookDesc;
  final String? initialBookImage;

  const AddNewBook({
    Key? key,
    this.initialBookName,
    this.initialBookPrice,
    this.initialBookAuthor,
    this.initialBookDesc,
    this.initialBookImage,
  }) : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  late TextEditingController booknamecontroller;
  late TextEditingController bookpricecontroller;
  late TextEditingController bookauthorcontroller;
  late TextEditingController bookdesccontroller;
  UserInputFeild feild = UserInputFeild();
  bool isLoading = false;
  String dropdownvalue = "Select Category";
  XFile? image;
  String imagebuttontext = "Upload";

  // List of items in our dropdown menu
  var items = [
    "Select Category",
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  void initState() {
    super.initState();
    booknamecontroller = TextEditingController(text: widget.initialBookName);
    bookpricecontroller = TextEditingController(text: widget.initialBookPrice);
    bookauthorcontroller =
        TextEditingController(text: widget.initialBookAuthor);
    bookdesccontroller = TextEditingController(text: widget.initialBookDesc);
  }

  @override
  void dispose() {
    booknamecontroller.dispose();
    bookpricecontroller.dispose();
    bookauthorcontroller.dispose();
    bookdesccontroller.dispose();
    super.dispose();
  }

 Future<void> handleImagePicker(context,) async {
  final ImagePicker _picker = ImagePicker();
  
  // Show options for choosing from the gallery or capturing from the camera
  final action = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (action != null) {
    XFile? pickedfile = (await _picker.pickImage(source: action));

    if (pickedfile != null) {
      image = pickedfile;
      setState(() {
                        imagebuttontext = "Uploaded";
                      });
      // Handle the picked image
      // For example, you can display the image or upload it to a server
    }
  }
}

  Future<void> addBook() async {
    try {

      Uint8List? _bytes = await image?.readAsBytes();
      String base64Image = base64Encode(_bytes!);
        Map<dynamic,dynamic>   response = await BookAPI.addBook(
        bookname: booknamecontroller.text,
        price: int.parse(bookpricecontroller.text),
        description: bookdesccontroller.text,
        author: bookauthorcontroller.text,
        image:base64Image,
        category: dropdownvalue
      );
      if (response["success"]) {
        ProductPageclass product = ProductPageclass(name: response["bookname"], imageUrl: response["image"], price: response["price"]);
        Navigator.pop(context);
           RouterClass.AddScreen(context,ProductPage(product:product));
           
        // InputComponent.showWarningSnackBar(context, "Book Added Successfully");
      } else {
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    } catch (error) {
      print(error);
      InputComponent.showWarningSnackBar(context, error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.screenAppbar("New Book"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              feild.inputContainerText(context, booknamecontroller,
                  "Enter Book Name", Icon(Icons.book)),
              SizedBox(
                height: 12,
              ),
              feild.inputContainerText(context, bookauthorcontroller,
                  "Book Author Name", Icon(Icons.person)),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                width: mediaQuery.width * .71,
                height: mediaQuery.height * .06,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(38, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              feild.inputContainerText(context, bookpricecontroller,
                  "Enter Price ", Icon(Icons.price_change)),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  width: mediaQuery.width * .71,
                  // height: mediaQuery.height * .06,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(38, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: bookdesccontroller,
                    maxLines: 8,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      // suffixIcon: Icon(Icons.description),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload Image of book",
                    style: TextStyle(),
                  ),
                  SizedBox(
                    width: mediaQuery.width * .05,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      handleImagePicker(context);
                      
                    },
                    child: Text(
                      "$imagebuttontext",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              feild.buttonContainer(context, "Submit", () async {
                if (bookauthorcontroller.text.isEmpty ||
                    bookdesccontroller.text.isEmpty ||
                    booknamecontroller.text.isEmpty ||
                    bookpricecontroller.text.isEmpty) {
                  InputComponent.showWarningSnackBar(
                      context, "Enter All Information");
                } else if (image == null) {
                  InputComponent.showWarningSnackBar(
                      context, "Select an Image");
                }else if(dropdownvalue == "Select Category"){
                  InputComponent.showWarningSnackBar(
                      context, "Choose Category");
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  addBook();
                }
              }, isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
