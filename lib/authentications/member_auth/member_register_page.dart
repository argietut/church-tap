import 'package:bethel_app_final/Services/Functions/member_functions/member_auth_functions.dart';
import 'package:bethel_app_final/authentications/auth_components/signup_button.dart';
import 'package:bethel_app_final/authentications/auth_components/my_textfield.dart';
import 'package:bethel_app_final/authentications/member_auth/member_login_page.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';

class MemberRegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const MemberRegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<MemberRegisterPage> createState() => _MemberRegisterPageState();
}

class _MemberRegisterPageState extends State<MemberRegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    try {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();

      // Validate input fields
      if (username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill up all fields."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Email validation logic
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid email address format."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
      if (!email.endsWith("@gmail.com")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address format."),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

     // Password validation logic
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 8 characters long."),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+$').hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must contain both letters and numbers."),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords don't match!"),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Sign up the user
      await MemberAuthServices.signupUser(email, password, username);

      // Show a loading indicator for 2 seconds
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );

      // Delay for 2 seconds before navigating to the login page
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to the member login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MemberLoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create account: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/churchmepicture.png',
                  width: 400,
                  height: 250,
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(
                      right: 150), // Adjust the left padding as needed
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 26,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                MyButton1(
                  onTap: signUserUp,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: appGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
