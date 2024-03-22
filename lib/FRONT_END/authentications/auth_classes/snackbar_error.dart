import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showCustomSnackbar(
      BuildContext context, {
        required String title,
        required List<String> messages,
      }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10), // Spacing between title and messages
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messages.map((message) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}