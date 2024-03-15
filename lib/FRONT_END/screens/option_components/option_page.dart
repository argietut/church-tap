import 'dart:ui';
import 'package:bethel_app_final/FRONT_END/authentications/admin_auth/admin_auth_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/option_to_loginform/option_what_account_to_use.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:bethel_app_final/FRONT_END/screens/option_components/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Church Tap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 34,
            fontFamily: 'ProtestRiot',
            color: appGreen,
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.contact_emergency_outlined),
                title: const Text('Contact Us'),
                onTap: () {
                  Get.to(const ContactUs());
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/churchmain.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.transparent, // Important for BackdropFilter to work
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: GestureDetector(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => AdminAuthPage(),
                                transition: Transition.fade,
                            duration: const Duration(seconds: 1));
                          },
                          child: const Column(
                            children: [
                              Center(
                                child: Text(
                                  'Admin',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: appGreen,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Access your Admin Account.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: GestureDetector(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => OptionToPlatformToLogin(),
                                transition: Transition.fade,
                                duration: const Duration(seconds: 1));
                          },
                          child: const Column(
                            children: [
                              Center(
                                child: Text(
                                  'Member',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: appGreen,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Sign in to your account or create a new account.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
