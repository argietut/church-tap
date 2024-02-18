import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/calendar.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/give_us_feedback.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/my_profile.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/privacy_policy.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/settings.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/terms_of_service.dart';
import 'package:bethel_app_final/memberScreens/screen_pages/profile_screen_pages/visit_the_help_center.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Profile(),
    ));
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final textStyleState = const TextStyle(fontSize: 11.0, color: Colors.white);

  final textStyleTop = const TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white);

  final textStyle2 = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87),
                    ),
                  ],
                )
              ],
            ),
          ),
          ClipRRect(
            child: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              decoration: const BoxDecoration(
                color: Colors.black12,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              width: 50,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Account settings".toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfile()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Personal informations",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.person,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Calendar()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Calendar",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.calendar_month_outlined,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.settings,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Support".toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VisitTheHelpCenter()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Visit the Help Center",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.help_center_outlined,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GiveUsFeedBack()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Give us feedback",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.feedback_outlined,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
            Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "LEGAL".toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),

           ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsOfService()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Terms of Service",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.policy_outlined,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.policy_outlined,
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Log out".toUpperCase(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Sign Out'),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Sign out of Firebase Authentication
                          await FirebaseAuth.instance.signOut();

                          // Check if the user signed in with Google
                          final googleSignIn = GoogleSignIn();
                          if (await googleSignIn.isSignedIn()) {
                            await googleSignIn.signOut(); // Sign out of Google Sign-In
                          }

                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            width: 50,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Version 2.14.2024",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
