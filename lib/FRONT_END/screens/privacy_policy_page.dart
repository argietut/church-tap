import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column( // removed const from here
            // Changed from a single Text widget to a Column widget
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                "February 17, 2024 " ,
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
