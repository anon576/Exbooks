import 'package:bookbazaar/apis/user_api.dart';
import 'package:bookbazaar/components/app_properties.dart';
import 'package:bookbazaar/components/error%20_snackbar.dart';
import 'package:bookbazaar/components/user_input_feild.dart';
import 'package:flutter/material.dart';

import '../components/route.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final UserInputFeild feild = UserInputFeild();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  bool isLoading = false;

  Future<void> registerUser() async {
    try {
      bool response = await ApiService.registerUser(
          name: namecontroller.text,
          lastname: lastnamecontroller.text,
          mobileNo: mobilecontroller.text,
          city: adresscontroller.text);
      if (response) {
         RouterClass.ReplaceScreen(context,"/home");
      } else {
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    } catch (error) {
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
      extendBodyBehindAppBar: true,
      backgroundColor: BackgroundColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: mediaQuery.height * .1,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 7.0),
              child: const Center(
                  child: Text(
                'BookBazaar!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 15.0),
              child: const Center(
                child: Text('Please fill your details to start with BookBazaar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(height: 30),
          feild.inputContainerText(context, namecontroller, "Enter First Name",
              Icon(Icons.person_2_outlined)),
          SizedBox(height: 25),
          feild.inputContainerText(context, lastnamecontroller,
              "Enter Last Name", Icon(Icons.last_page_outlined)),
          SizedBox(height: 25),
          feild.inputContainerText(context, mobilecontroller, "Enter Mobile No",
              Icon(Icons.mobile_friendly_outlined)),
          SizedBox(height: 25),
          feild.inputContainerText(context, adresscontroller, "Enter City Name",
              Icon(Icons.location_city)),
          SizedBox(height: 25),
          feild.buttonContainer(context, "Start Booking", () async {
            if (namecontroller.text.isEmpty ||
                lastnamecontroller.text.isEmpty ||
                mobilecontroller.text.isEmpty ||
                adresscontroller.text.isEmpty) {
              InputComponent.showWarningSnackBar(context, "Enter Valid Data");
            } else if (mobilecontroller.text.length != 10) {
              InputComponent.showWarningSnackBar(
                  context, "Enter Valid Mobile No");
            } else {
              setState(() {
                isLoading = true;
              });
              await registerUser();
            }
          }, isLoading),
        ],
      )),
    );
  }
}
