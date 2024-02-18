import 'package:bethel_app_final/colors/color.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black)),
      ),
    );
  }
}

class MyButton1 extends StatelessWidget {
  final  Function()? onTap;

  const MyButton1({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(color: appGreen,// Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child:const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: appGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Login", 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const SquareTile({
    Key? key, // changed 'super.key' to 'Key? key'
    required this.imagePath,
    required this.onTap,
  }) : super(key: key); // added super constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8), // Reduced padding
        decoration: BoxDecoration(
          border: Border.all(color: appBlack),
          borderRadius: BorderRadius.circular(8), // Reduced border radius
          color: appWhite,
        ),
        child: Image.asset(
          imagePath,
          height: 32, // Increased height
        ),
      ),
    );
  }
}
