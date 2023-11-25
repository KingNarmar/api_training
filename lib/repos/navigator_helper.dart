import 'package:flutter/material.dart';

abstract class NavigatorHelper {
  static goTo(context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static goToAndOff(context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static goBack(context) {
    Navigator.pop(context);
  }

  static showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
