import 'dart:async';
import 'package:bethel_app_final/screens/option_page.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                const OptionPage(), // aha mo navigate ig human sa loading...
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/churchmepicture.png',
                width: 400,
                height: 400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Church me',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProtestRiot',
                color: appGreen,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color:appGreen,
            ),
          ],
        ),
      ),
    );
  }
}