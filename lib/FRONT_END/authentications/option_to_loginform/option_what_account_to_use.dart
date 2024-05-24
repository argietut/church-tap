import 'package:bethel_app_final/FRONT_END/MemberScreens/screens/terms_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_login_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_register_page.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionToPlatformToLogin extends StatelessWidget {
  const OptionToPlatformToLogin({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/churchmain.png',
                width: 380,
                height: 240,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome To',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: appBlack,
                ),
              ),
              const Text(
                'Church Tap',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProtestRiot',
                  color: appGreen,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal:45),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      height: 42, // Adjusted height
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          Get.to(() => MemberRegisterPage(
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGN UP WITH E-MAIL',
                                style: TextStyle(
                                  color: appWhite,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'or',
                style: TextStyle(
                  color: appBlack,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MemberLoginPage(),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 500));
                    },
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('By signing in you agree to our'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Terms(),
                          ),
                        );
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Terms(),
                            ),
                          );
                        },
                        child: const Text(
                          'Terms of Use',
                          style: TextStyle(
                            color: appGreen,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
