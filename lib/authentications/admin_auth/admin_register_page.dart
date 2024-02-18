import 'package:bethel_app_final/authentications/auth_classes/class_page.dart';
import 'package:bethel_app_final/colors/color.dart';
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
  } catch (e) {
    print(e.toString());
    // Handle exceptions if necessary
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