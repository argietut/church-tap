import 'package:bethel_app_final/authentication_pages/auth_components/signup_button.dart';
import 'package:bethel_app_final/authentication_pages/auth_components/my_textfield.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );


    try{
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      }else{
        showErrorMessage("Passwords don't match!");
      }

      Navigator.pop(context);

    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder:(context){
        return  AlertDialog(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              message ,
              style: const TextStyle(
                  color: Colors.white),
            ),
          ),
        );
      },
    );
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

                const SizedBox(height: 2),

               Image.asset(
                  'assets/images/churchmepicture.png',
                  width: 300,
                  height: 300,
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

                const SizedBox(height: 20),

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