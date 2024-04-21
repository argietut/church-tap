  /*

  import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_home.dart';
  import 'package:bethel_app_final/FRONT_END/AdminScreens/widget_admin/admin_navigation_bar.dart';
  import 'package:bethel_app_final/FRONT_END/MemberScreens/home_page.dart';
  import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/navigation_bar.dart';
  import 'package:bethel_app_final/FRONT_END/authentications/member_auth/register_or_login_page.dart';
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
              return const AdminNavigationPage();
            }
            else{
              return const MemberLoginOrRegister();
            }
          },
        ),
      );
    }
  }
  //LANDING PAGE*/
