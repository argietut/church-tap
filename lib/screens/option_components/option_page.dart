import 'dart:ui';
import 'package:bethel_app_final/authentications/admin_auth/admin_auth_page.dart';
import 'package:bethel_app_final/authentications/member_auth/member_auth_page.dart';
import 'package:bethel_app_final/screens/option_components/about_us.dart';
import 'package:bethel_app_final/screens/option_components/contact_us.dart';
import 'package:bethel_app_final/screens/option_components/support_resources.dart';
import 'package:bethel_app_final/constant/color.dart';
import 'package:flutter/material.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Church Me',
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
                leading: const Icon(Icons.support_outlined),
                title: const Text('Support & Resources'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SupportAndResources()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.abc_outlined),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_emergency_outlined),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ContactUs()),
                  );
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
                  'assets/images/churchmepicture.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors
                        .transparent, // Important for BackdropFilter to work
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
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminAuthPage()),
                          );
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MemberAuthPage()),
                          );
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
                  ],
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         TextButton(
          //           onPressed: () {
          //             // Navigate to Terms & Conditions page
          //           },
          //           child: const Text(
          //             'Terms & Conditions',
          //             style: TextStyle(color: appBlack),
          //           ),
          //         ),
          //         TextButton(
          //           onPressed: () {
          //             // Navigate to Privacy Policy page
          //           },
          //           child: const Text(
          //             'Privacy Policy',
          //             style: TextStyle(color: appBlack),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
