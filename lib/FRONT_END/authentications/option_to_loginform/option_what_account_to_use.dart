import 'package:bethel_app_final/BACK_END/Services/Functions/Member_Functions/member_functions.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/squaretile.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_auth_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_register_page.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:bethel_app_final/FRONT_END/screens/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionToPlatformToLogin extends StatelessWidget {
   OptionToPlatformToLogin({Key? key, this.onTap}) : super(key: key);

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: true,
        title: const Text(''),


      ),

      body:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/images/churchmain.png',
                   width: 400,
                  height: 250,
                ),
                const SizedBox(height: 30),
              const Text('Welcome To',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                 // fontFamily:'GreatVibes',
                    color: appBlack,
                  ),
              ),
              const Text('Church Tap',
                  style: TextStyle(
                      fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProtestRiot',
                    color: appGreen

                  )
              ),
              const SizedBox(height: 20),
              Container(
                width: 280,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await AuthServiceGoogle().signInWithGoogle(context); // Pass the context here
                    } catch (e) {
                      print("Error signing in with Google: $e");
                      // Handle error
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appBlue,
                    foregroundColor: appWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) => SquareTile(
                          onTap: () async {
                            try {
                              await AuthServiceGoogle().signInWithGoogle(context); // Pass the context here
                            } catch (e) {
                              print("Error signing in with Google: $e");
                              // Handle error
                            }
                          },
                          imagePath: 'assets/images/google-logo.png',
                        ),
                      ),
                      const SizedBox(width: 8), // Add some space between the image and text
                      const Text('CONTINUE WITH GOOGLE', ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'or',
                style: TextStyle(color: appBlack, fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Create your account',
                        style: TextStyle(
                          fontSize: 18
                        ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Get.to(() =>  MemberRegisterPage(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                  transition: Transition.zoom,
                                  duration: const Duration(seconds: 1),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.email),
                                  SizedBox(width: 10),
                                  Text(
                                    'SIGN UP WITH E-MAIL',
                                    style: TextStyle(
                                      color: appBlack,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 280,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: appBlack),
                    borderRadius: BorderRadius.circular(8),
                    color: appWhite,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10), // Adjust padding as needed
                    child: Center(
                      child: Text(
                        'SEE MORE OPTIONS',
                        style: TextStyle(color: appBlack),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Text('Already have an account?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const MemberAuthPage(),
                          transition: Transition.leftToRightWithFade,
                        duration: const Duration(seconds: 1)
                      );
                    },

                    child: const Text(
                      'Login now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appGreen,
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0), // Adjust padding as needed
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
                    // const Text('and'),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const PrivacyPolicyPage(),
                    //       ),
                    //     );
                    //   },
                    //   child: const Text(
                    //     'Privacy Policy',
                    //     style: TextStyle(
                    //       color: appGreen,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // ),
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
