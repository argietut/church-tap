
import 'package:bethel_app_final/authentication_pages/admin_auth/admin_register_or_login.dart';
import 'package:bethel_app_final/widgets/navigation_bar.dart';
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
            return const HomePage();
          }
          else{
            return const AdminLoginOrRegister();
          }

        },
      ),
    );
  }
}
