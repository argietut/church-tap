
import 'package:bethel_app_final/authentications/member_auth/register_or_login_page.dart';
import 'package:bethel_app_final/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MemberAuthPage extends StatelessWidget {
  const MemberAuthPage({super.key});

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
            return const MemberLoginOrRegister();
          }

        },
      ),
    );
  }
}
