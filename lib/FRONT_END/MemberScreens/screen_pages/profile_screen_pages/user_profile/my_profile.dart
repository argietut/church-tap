import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/profile_screen_pages/user_profile/GetUserInformation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  String? uniqueID; // Make it nullable

  @override
  void initState() {
    super.initState();
    getUniqueID();
  }

  Future<void> getUniqueID() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc("members")
        .collection(user.uid)
        .doc("About User")
        .get();

    if (snapshot.exists) {
      setState(() {
        uniqueID = user.uid;
      });
    } else {
      print("Document does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: uniqueID != null
              ? GetUserInformation(uniqueID: uniqueID!)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}