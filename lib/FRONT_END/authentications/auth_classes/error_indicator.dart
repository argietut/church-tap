import 'package:flutter/material.dart';

class DialogHelper {
  static Future<void> showLoadingDialog(BuildContext context, String message) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );

    // Delay for 1 second before dismissing the dialog
    await Future.delayed(Duration(seconds: 1));
    dismissLoadingDialog(context);
  }

  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
