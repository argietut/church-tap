import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';

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