import 'package:bethel_app_final/Services/Functions/admin_functions/admin_auth_functions.dart';
import 'package:bethel_app_final/authentications/auth_components/signup_button.dart';
import 'package:bethel_app_final/authentications/auth_components/my_textfield.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';



class AdminRegisterPage extends StatefulWidget {

  final void Function()? onTap;

  const AdminRegisterPage({super.key, required this.onTap});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  //editing text
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  //sign up method
  void signUserUp() async {
    try {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();

      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill up all fields."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Your email validation logic
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter a valid email address."),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Password validation logic
      if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password)) {
        // Your password validation error handling
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password must be at least 8 characters long and contain letters and numbers."),
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

      await AdminAuthServices.signupAdmin(email, password, username); // Sign up the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully."),
          duration: Duration(seconds: 3),
        ),
      );
      // Clear text field controllers after successful sign up
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create account: $e"),
          duration: Duration(seconds: 3),
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

                const Padding(
                  padding: EdgeInsets.only(right: 150), // Adjust the left padding as needed
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

                const  SizedBox(height: 10),

                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const  SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const  SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const  SizedBox(height: 15),

                MyButton1(
                  onTap: signUserUp ,
                ),

                const  SizedBox(height: 10),

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}