import 'package:bethel_app_final/BACK_END/Services/Functions/Member_Functions/member_functions.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/class_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_auth_page.dart';
import 'package:bethel_app_final/FRONT_END/authentications/member_auth/member_register_page.dart';
import 'package:bethel_app_final/FRONT_END/colors/color.dart';
import 'package:bethel_app_final/FRONT_END/screens/privacy_policy_page.dart';
import 'package:bethel_app_final/FRONT_END/screens/terms_page.dart';
import 'package:flutter/material.dart';

class OptionToPlatformToLogin extends StatelessWidget {
  const OptionToPlatformToLogin({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: appGreen2,
      appBar: AppBar(
         automaticallyImplyLeading: true,
        title: const Text(''),
        // backgroundColor: appGreen2,
        
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
                const SizedBox(height: 100),
              const Text('Welcome To',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                 // fontFamily:'GreatVibes',
                    color: appBlack,
                  ),
              ),
              const Text('Church Tap',
                  style: TextStyle(
                      fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProtestRiot',
                    color: appBlack

                  )
              ),
              const SizedBox(height: 30),
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


                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  MemberRegisterPage(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
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
                                        fontSize: 20,
                                      ),
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
                  GestureDetector(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const MemberAuthPage()));
                      },
                      child: const Text('Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: appBlack,
                        fontSize: 14
                      ),),
                    ),
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
                        GestureDetector(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Terms()),
                              );
                            },
                            child: const Text('Terms',
                            style: TextStyle(color: appBlack,
                            decoration: TextDecoration.underline
                            ),
                            ),
                          ),
                        ),
                        const Text('and'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const PrivacyPolicyPage()),
                            );
                          },
                          child: const Text('Privacy Policy',
                           style: TextStyle(color: appBlack,
                          decoration: TextDecoration.underline
                          ),
                          ),
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
