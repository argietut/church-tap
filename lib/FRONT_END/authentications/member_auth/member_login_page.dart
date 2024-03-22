import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/navigation_bar.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/snackbar_error.dart';
import 'package:flutter/material.dart';
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
  bool _obscurePassword = true; // To toggle password visibility
  bool _loading = false;

  void signUserIn() async {
    try {
      setState(() {
        _loading = true; // Start circular loading
      });

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Inside your function or method
      if (email.isEmpty || password.isEmpty) {
        SnackbarUtils.showCustomSnackbar(
          context,
          title: 'Ohh my god!',
          messages: [
            'Please fill out all fields to proceed.',
            'Please try again!',
          ],
        );
        return;
      }

      try {
        bool loginSuccessful = await tapAuth.loginUserAuth(email, password);

        if (!loginSuccessful) {
          SnackbarUtils.showCustomSnackbar(
            context,
            title: 'Ohh my god!',
            messages: [
              'Your account is not verified yet.',
              'Please check your email and verify your account.',
            ],
          );

        } else {
          // If login successful and account verified, navigate to home page
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } on Exception catch (e) {
        // Catch exceptions thrown by loginUserAuth
        String errorMessage = 'An error occurred. Please try again later.';
        if (e.toString() == 'Incorrect email') {
          errorMessage = 'Incorrect email. Please check your email and try again.';
        } else if (e.toString() == 'Incorrect password') {
          errorMessage = 'Incorrect password. Please check your password and try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _loading = false; // Stop circular loading
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: true),
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
                      Navigator.pop(context, true);
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
    );
  }
}
