import 'dart:async';

import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/profile_screen_pages/changepassword.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  XFile? _image;
  TapAuth tapAuth = TapAuth();
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  void initState() {
    print("HELLOWASHFKASJFASDGADSFGAFDH");
    print(tapAuth.auth.currentUser?.photoURL);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // Add a small delay to simulate loading
          await Future.delayed(Duration(milliseconds: 1000));
          setState(() {});
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: appGreen,
                ),
                const SizedBox(height: 60),
                Center(
                  child: Stack(
                    children: [
                      Builder(
                        builder: (context) => CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "${tapAuth.auth.currentUser?.photoURL}"),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: _addImageField,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                        bottom: -10,
                        left: 65,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          Text(
                            'Name: ${tapAuth.auth.currentUser?.displayName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          const SizedBox(width: 10),
                          Text(
                            'Email: ${tapAuth.auth.currentUser?.email}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePassword(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(
                                appGreen2)
                        ),
                        child: const Text(
                          'Change Password',
                          style: TextStyle(
                              color: appBlack
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addImageField() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
      // Update profile picture
      tapAuth.auth.currentUser?.updatePhotoURL(image.path);
      // Add loading delay
      await Future.delayed(Duration(seconds: 1));
      // Refresh the page after updating the picture
      _refreshIndicatorKey.currentState?.show();
    }
  }
}