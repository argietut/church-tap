import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/navigation_bar.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_button.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/my_textfield.dart';
import 'package:bethel_app_final/FRONT_END/authentications/forgot_password.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:get/get.dart';

class MemberLoginPage extends StatefulWidget {
  final void Function()? onTap;

  const MemberLoginPage({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  State<MemberLoginPage> createState() => _MemberLoginPageState();
}

class _MemberLoginPageState extends State<MemberLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TapAuth tapAuth = TapAuth();
  bool _obscurePassword = true;
  bool _loading = false;

  void showSnackbar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void signUserIn() async {
    try {
      setState(() {
        _loading = true;
      });

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showSnackbar('Please fill out all fields to proceed. Please try again!',
            backgroundColor: Colors.red);
        return;
      }

      try {
        bool loginSuccessful = await tapAuth.loginUserAuth(email, password);

        if (!loginSuccessful) {
          showSnackbar('Your account is not verified yet. Please check your email and verify your account.',
              backgroundColor: Colors.red);
        } else {

          await Future.delayed(const Duration(seconds: 1));

          // Navigate to HomePage and await until navigation completes
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );

          // Stop the loading once navigation is completed
          setState(() {
            _loading = false;
          });
        }
      } on Exception catch (e) {
        // Catch exceptions thrown by loginUserAuth
        String errorMessage = 'An error occurred. Please try again later.';
        if (e.toString() == 'Incorrect email') {
          errorMessage = 'Incorrect email. Please check your email and try again.';
        } else if (e.toString() == 'Incorrect password') {
          errorMessage = 'Incorrect password. Please check your password and try again.';
        }
        showSnackbar(errorMessage, backgroundColor: Colors.red);
      }
    } catch (e) {
      print("Error occurred: $e");
      showSnackbar('An error occurred. Please try again later.',
          backgroundColor: Colors.red);
    } finally {
      setState(() {
        _loading = false; // Stop circular loading
      });
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/churchmain.png',
                    width: 400,
                    height: 250,
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(right: 170),
                    child: Text(
                      'Member Login',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(() => const ForgotPassword(),
                                transition: Transition.fadeIn,
                                duration: const Duration(seconds: 1)
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: appGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    onTap: signUserIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
