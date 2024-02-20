import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_login_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_register_page.dart';
import 'package:flutter/material.dart';

class MemberLoginOrRegister extends StatefulWidget {
  const MemberLoginOrRegister({
    super.key,
  });

  @override
  State<MemberLoginOrRegister> createState() => _MemberLoginOrRegisterState();
}

class _MemberLoginOrRegisterState extends State<MemberLoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return MemberLoginPage(onTap: togglePages);
    } else {
      return MemberRegisterPage(onTap: togglePages);
    }
  }
}
