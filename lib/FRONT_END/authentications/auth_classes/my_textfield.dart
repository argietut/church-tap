import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon; // Added suffixIcon parameter

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon, // Initialize suffixIcon parameter
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius:BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius:BorderRadius.all(Radius.circular(10)),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          suffixIcon: widget.suffixIcon, // Use suffixIcon parameter
        ),
      ),
    );
  }
}
