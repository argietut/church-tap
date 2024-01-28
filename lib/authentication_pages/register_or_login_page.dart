
import 'package:bethel_app_final/authentication_pages/login_page.dart';
import 'package:bethel_app_final/authentication_pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  // void Function()? onTap;
  const LoginOrRegister({super.key,});


  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
          onTap: togglePages
      );
    }else {
      return RegisterPage(
          onTap: togglePages
      );
    }
  }
}

