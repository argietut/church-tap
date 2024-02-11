
import 'package:bethel_app_final/adminScreens/home_page.dart';
import 'package:bethel_app_final/authentications/admin_auth/admin_register_or_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AdminAuthPage extends StatelessWidget {
  const AdminAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return const AdminHomePage();
          }
          else{
            return const AdminLoginOrRegister();
          }

        },
      ),
    );
  }
}
