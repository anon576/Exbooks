import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class InputComponent{


   static void showWarningSnackBar(BuildContext context,dynamic test) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$test'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context)
                .hideCurrentSnackBar(); // Hide the snackbar
          },
        ),
      ),
    );
  }

  static  bool Validate(String email) {
    bool _isValid = EmailValidator.validate(email);
    return _isValid;
  }
}