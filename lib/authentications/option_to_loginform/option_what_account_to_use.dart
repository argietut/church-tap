import 'package:bethel_app_final/Services/Functions/Member_Functions/member_functions.dart';
import 'package:bethel_app_final/authentications/auth_classes/class_page.dart';
import 'package:bethel_app_final/authentications/member_auth/member_auth_page.dart';
import 'package:bethel_app_final/colors/color.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/privacy_policy.dart';
import 'package:bethel_app_final/screens/terms_page.dart';
import 'package:flutter/material.dart';

class OptionToPlatformToLogin extends StatelessWidget {
  const OptionToPlatformToLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(''),
      ),

      body:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Step into a place where love thrive',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                  fontFamily:'GreatVibes',
                    color: appGreen,
                  ),
              ),
              const Text('and faith grows.',
                  style: TextStyle(
                      fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GreatVibes',
                    color: appGreen

                  )
              ),
              const SizedBox(height: 120),
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
                    primary: appBlue,
                    onPrimary: appWhite,
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
              const SizedBox(height: 12),
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
                          fontSize: 30
                        ),
                        ),
                        content: Container(
                          width: double.maxFinite,
                          child: Column(

                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  try {
                                    // Invoke signInWithFacebook method from AuthServiceFacebook
                                    await AuthServiceFacebook().signInWithFacebook(context);
                                  } catch (e) {
                                    print("Error signing in with Facebook: $e");
                                    // Handle error
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.facebook),
                                    SizedBox(width: 10),
                                    Text(
                                      'LOGIN WITH FACEBOOK',
                                      style: TextStyle(
                                        color: appBlue, // Assuming appBlue is defined somewhere
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context)
                                  //   => const MemberRegisterPage(onTap: () {})),
                                  // );
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.email),
                                    SizedBox(width: 10),
                                    Text(
                                      'SIGN UP WITH E-MAIL',
                                      style: TextStyle(
                                          color: appBlack,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MemberAuthPage()));
                    },
                    child: const Text('Login now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0), // Adjust padding as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('By signing in you agree to our'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Terms()),
                            );
                          },
                          child: const Text('Terms'),
                        ),
                        const Text('and'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
                            );
                          },
                          child: const Text('Privacy Policy'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
