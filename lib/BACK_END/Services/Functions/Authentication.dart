import 'dart:developer';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/profile_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/navigation_bar.dart';
import 'package:bethel_app_final/FRONT_END/authentications/auth_classes/snackbar_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TapAuth {
  late String _uid;
  late String _name = '';
  late String _email = '';
  late String _password;
  late String _profilePicture = '';
  late String _token;
  late UserCredential _userCredential;
  User? _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserStorage store;



  Future<void> createUserAuth(String name, String email,
      String password,String type) async {
    try {
      _userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.currentUser?.sendEmailVerification();
      _user = _userCredential.user;
      _name = name;
      setRegisterAllDetails();
      if(_user!.uid.length > 4) {
        store = UserStorage();
        store.createUser(_uid,registerUserToFireStore(),type);
      }
    } catch (e) {
      log("ERROR CODE AUTHENTICATION: $e");
    }
  }

  Future<bool> loginUserAuth(String email, String password) async {
    auth.signOut();
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          // Sign out the user if the email is not verified
          await auth.signOut();
          return false; // Account not verified
        } else {
          auth.currentUser?.updatePhotoURL('assets/images/default.png');
          // Proceed to sign in the user since the email is verified
          print(auth.currentUser?.photoURL);
          return true; // Account verified
        }
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      print("AUTH ERROR : $e");
      return false; // Login failed
    }
  }

Future<void> sendUserVerifcationEmail() async{
    auth.currentUser?.sendEmailVerification();
}

    void setRegisterAllDetails() {
      _uid = _user!.uid;
      _email = _user!.email!;
    }

    setid(){
    _uid = _user!.uid;
    }

//CAREFUL USING THIS!
    String getUniqueID() {
      return _uid;
    }

    String getUsername() {
      return _name;
    }

    getEmail() {
      return _email;
    }

    registerUserToFireStore() {
      var user_full_details = <String, String>{
        "name": getUsername(),
        "email": getEmail(),
        "Unique ID": getUniqueID()
      };
      return user_full_details;
    }

    //get current user ID
    getCurrentUserUID(){
    return auth.currentUser?.uid;
    }

  // Get current user name
  String getCurrentUserName() {
    return _name;
  }

  //para sa  pending appointment
  User? getCurrentUser() {
    return tapAuth.auth.currentUser;
  }
}

class AuthServiceGoogle {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        print("Google sign-in canceled or failed");
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          // Save user data using UserStorage
          final UserStorage userStorage = UserStorage();
          await userStorage.createUser(
            userCredential.user!.uid,
            {
              "name": userCredential.user!.displayName ?? "",
              "email": userCredential.user!.email ?? "",
              "Unique ID": userCredential.user!.uid,
            },
            'members',
          );
          // Initialize TapAuth and set user details
          final TapAuth tapAuth = TapAuth();
          tapAuth.setRegisterAllDetails();

          // Navigate to the homepage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          // User's email is not verified, show a Snackbar
          SnackbarUtils.showCustomSnackbar(
            context,
            title: 'Account Not Verified',
            messages: [
              'Your account is not verified yet.',
              'Please check your email and verify your account.',
            ],
          );
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      // Handle error
    }
  }
}

