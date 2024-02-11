import 'package:bethel_app_final/Services/Functions/admin_functions/admin_auth_functions.dart';
import 'package:bethel_app_final/authentications/auth_components/login_button.dart';
import 'package:bethel_app_final/authentications/auth_components/my_textfield.dart';
import 'package:bethel_app_final/authentications/forgot_password.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  final void Function()? onTap;

  const AdminLogin({
    super.key,
    this.onTap,
  });

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter email and password.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      await AdminAuthServices.signinAdmin(email, password); // Sign in the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signed in successfully."),
          duration: Duration(seconds: 3),
        ),
      );
// Clear text field controllers after successful sign in
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to sign in: $e"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
      automaticallyImplyLeading: true, 
      title: const Text(''),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                // logo
                Image.asset(
                  'assets/images/churchmepicture.png',
                  width: 300,
                  height: 300,
                ),

                const Padding(
                  padding: EdgeInsets.only(
                      right: 200), // Adjust the left padding as needed
                  child: Text(
                    'Admin Login',
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
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
                          color: appGreen,
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
