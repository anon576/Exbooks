import 'package:bookbazaar/components/app_properties.dart';
import 'package:bookbazaar/components/route.dart';
import 'package:bookbazaar/components/share_prefs.dart';
import 'package:bookbazaar/components/user_input_feild.dart';
import 'package:flutter/material.dart';

import '../../apis/user_api.dart';
import '../../components/error _snackbar.dart';

class StartUp extends StatefulWidget {
  StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final UserInputFeild feild = UserInputFeild();
  bool _isLoading = false;
  bool isOtp = false;
  bool userRegisterd = false;
  int otp = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendDataToServer() async {
    try {
      Map<dynamic, dynamic> data = await ApiService.sendDataToServer(
        email: _emailController.text,
      );
      if (data['success']) {
        userRegisterd = data['userExist'];
        otp = int.parse(data['otp']);
        SharePrefs.storePrefs("email", _emailController.text, "string");
        isOtp = true;
      } else {
        // write code for snackbar error
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _OTPAction() async {
    try {
      if (otp == int.parse(_otpController.text)) {
         if (userRegisterd) {
          RouterClass.ReplaceScreen(context,"/home");
        } else {
           RouterClass.ReplaceScreen(context,"/userData");
        }
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: BackgroundColor,
      body: SizedBox(
        height: mediaQuery.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 190.0, 25.0, 5.0),
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB4A9),
                      shape: BoxShape.circle,
                    ),
                    child: const Stack(
                      children: [
                        Center(
                          child: Text(
                            "Glow",
                            style: TextStyle(
                                color: Color(0xFFFFF5F5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          right: 110,
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFFFFF5F5),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 7.0),
                  child: const Center(
                      child: Text(
                    'Welcome to BookBazaar!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 15.0),
                  child: const Center(
                    child: Text('Enter your email to start with BookBazaar',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ),
                ),
              ),
              feild.inputContainerText(context, _emailController, "Enter Email",
                  Icon(Icons.email_outlined)),
              isOtp
                  ? Column(
                      children: [
                        const SizedBox(height: 15),
                        feild.inputContainerText(context, _otpController,
                            "Enter OTP", Icon(Icons.password_outlined)),
                        SizedBox(height: 20.0),
                        feild.buttonContainer(context, "Verify OTP", () async {
                          if (_otpController.text.isEmpty) {
                            InputComponent.showWarningSnackBar(context, "Enter Valid OTP");
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            await _OTPAction();
                          }
                        }, _isLoading)
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 15),
                        feild.buttonContainer(context, "Join", () async {
                          if (_emailController.text.isEmpty) {
                            InputComponent.showWarningSnackBar(
                                context, "Enter Valid Email");
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            await _sendDataToServer(); // Call the function directly
                          }
                        }, _isLoading)
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
