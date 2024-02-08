import 'package:bethel_app_final/authentication_pages/auth_components/login_button.dart';
import 'package:bethel_app_final/authentication_pages/auth_components/my_textfield.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MemberLoginPage extends StatefulWidget {
  final void Function()? onTap;

  const MemberLoginPage({
    super.key,
    this.onTap,
  });

  @override
  State<MemberLoginPage> createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // sign user in method
 void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
} on FirebaseAuthException catch (e) {
  String errorMessage = 'Wrong email or password. Please try again.';

  if (e.code == 'user-not-found') {
    errorMessage = 'Account not found. Please check your email or register.';
  } else if (e.code == 'wrong-password') {
    errorMessage = 'Incorrect password. Please double-check and try again.';
  }

  // Check if the password length is less than 8 characters
  if (passwordController.text.length < 8) {
    errorMessage = 'Password should have at least 8 characters.';
  }

  // Implement a simple password strength detector
  if (passwordController.text.length >= 4 && passwordController.text.length <= 12) {
    errorMessage += ' Your password is weak.';
  } else if (passwordController.text.length > 8 && passwordController.text.length <= 16) {
    errorMessage += ' Your password is moderate.';
  } else if (passwordController.text.length > 10) {
    errorMessage += ' Your password is strong.';
  }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 2),

                // logo
                Image.asset(
                  'assets/images/churchmepicture.png',
                  width: 400,
                  height: 250,
                ),

                const SizedBox(height: 8),

                const Padding(
                  padding: EdgeInsets.only(
                      right: 180), // Adjust the left padding as needed
                  child: Text(
                    'Member Login',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 10),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color:appGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
