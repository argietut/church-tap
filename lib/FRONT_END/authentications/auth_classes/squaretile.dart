import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

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
          border: Border.all(color: appBlue),
          borderRadius: BorderRadius.circular(12), // Reduced border radius
          color: appBlue,
        ),
        child: Image.asset(
          imagePath,
          height: 32, // Increased height
        ),
      ),
    );
  }
}
