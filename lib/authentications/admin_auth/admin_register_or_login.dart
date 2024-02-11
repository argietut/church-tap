
import 'package:bethel_app_final/authentications/admin_auth/admin%20login_page.dart';
import 'package:bethel_app_final/authentications/admin_auth/admin_register_page.dart';
import 'package:flutter/material.dart';

class AdminLoginOrRegister extends StatefulWidget {
  // void Function()? onTap;
  const AdminLoginOrRegister({super.key,});


  @override
  State<AdminLoginOrRegister> createState() => _AdminLoginOrRegisterState();
}

class _AdminLoginOrRegisterState extends State<AdminLoginOrRegister> {

  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return AdminLogin(
          onTap: togglePages
      );
    }else {
      return AdminRegisterPage(
          onTap: togglePages
      );
    }
  }
}

