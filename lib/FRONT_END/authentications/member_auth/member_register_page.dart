import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_button1.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_textfield.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_login_page.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class MemberRegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const MemberRegisterPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MemberRegisterPage> createState() => _MemberRegisterPageState();
}

class _MemberRegisterPageState extends State<MemberRegisterPage> {
  TapAuth tapAuth = TapAuth();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePassword1 = true;

  void showSnackbar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void signUserUp() async {
    try {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();

      // Validate input fields
      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        showSnackbar('Please fill out all fields to proceed. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      // Email validation logic
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        showSnackbar('Please enter a valid email address format. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      if (!email.endsWith("@gmail.com")) {
        showSnackbar('Please enter a valid email address format. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      if (password.length < 8) {
        showSnackbar('Password must be at least 8 characters long. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');

      if (!passwordRegex.hasMatch(password)) {
        showSnackbar('Password must contain both letters and numbers and at least one symbol. Please try again!',
            backgroundColor: Colors.red);
        return;
      }


      // if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+$').hasMatch(password)) {
      //   showSnackbar('Password must contain both letters and numbers. Please try again!',
      //       backgroundColor: Colors.red);
      //   return;
      // }

      if (password != confirmPassword) {
        showSnackbar('Passwords don\'t match. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      // Sign up the user
      await tapAuth.createUserAuth(username, email, password, "members");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 2,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: appGreen,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  'Registration successful! Please check your email to verify your account.',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: appBlack),
                ),
              ),
            ],
          ),
        ),
      );

      showDialog(
        context: context,
        barrierDismissible: true,
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

      await Future.delayed(const Duration(seconds: 1));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MemberLoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red, // Adjust color as needed
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  'Failed to create account: $e', // Consider a user-friendly message here
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/churchmain.png',
                    width: 370,
                    height: 230,
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
                  const SizedBox(height: 15),
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
                    obscureText: _obscurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      child: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: _obscurePassword1,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscurePassword1 = !_obscurePassword1;
                        });
                      },
                      child: Icon(
                        _obscurePassword1 ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton1(
                    onTap: signUserUp,
                  ),
                  //  const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Already have an account?',
                  //       style: TextStyle(color: Colors.grey[700]),
                  //     ),
                  //     const SizedBox(width: 4),
                  //     GestureDetector(
                  //       onTap: widget.onTap,
                  //       child: const Text(
                  //         'Login now',
                  //         style: TextStyle(
                  //           color: appGreen,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
