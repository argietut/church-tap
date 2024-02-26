
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../FRONT_END/widgets/navigation_bar.dart';

// Member account authentication to Firebase
class MemberAuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> signupUser(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);

        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'userID': user.uid
        });
      }
    } catch (e) {
      // Handle errors gracefully
      throw 'Failed to create user: $e';
    }
  }

  static Future<void> signinUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Handle errors gracefully
      throw 'Failed to sign in: $e';
    }
  }
}



// accounts store to firestore firebase
class UserFirestoreServices {
  static Future<void> saveUser(String name, String email, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        
      });
    } catch (e) {
      print('Error saving user data to Firestore: $e');
      
      rethrow; 
    }
  }
}

// member authentication for google account
class AuthServiceGoogle {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Save user data to Firestore
        await UserFirestoreServices.saveUser(
            userCredential.user!.displayName ?? "",
            userCredential.user!.email ?? "",
            userCredential.user!.uid);

        // Navigate to the homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(), 
          ),
        );
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      // Handle error
    }
  }
}


//member authentication for facebook
// class AuthServiceFacebook {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//
//   Future<void> signInWithFacebook(BuildContext context) async {
//     try {
//       // Triggering Facebook Sign In
//       final LoginResult result = await _facebookAuth.login();
//
//       // Check if login is successful
//       if (result.status == LoginStatus.success) {
//         // Extracting access token
//         final AccessToken accessToken = result.accessToken!;
//
//         // Create Facebook auth credentials
//         final OAuthCredential credential =
//         FacebookAuthProvider.credential(accessToken.token);
//
//         // Sign in with Facebook credentials
//         final UserCredential userCredential =
//         await _firebaseAuth.signInWithCredential(credential);
//
//         // Check if user is signed in
//         if (userCredential.user != null) {
//           // Retrieve user profile data from Facebook
//           final profile = await _getUserProfile(result.accessToken!);
//
//           // Save user data to Firestore (you need to implement this)
//           // Example: await UserFirestoreServices.saveUser(
//           //     userCredential.user!.displayName ?? "",
//           //     userCredential.user!.email ?? "",
//           //     userCredential.user!.uid);
//
//           // Navigate to the homepage (you need to replace HomePage with your desired destination)
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomePage(), // Replace HomePage with your destination
//             ),
//           );
//         }
//       } else if (result.status == LoginStatus.cancelled) {
//         print('Facebook Sign in cancelled');
//       } else {
//         print('Facebook Sign in failed');
//       }
//     } catch (e) {
//       print("Error signing in with Facebook: $e");
//       // Handle error
//     }
//   }
//
//   Future<Map<String, dynamic>> _getUserProfile(AccessToken accessToken) async {
//     // Fetch user profile data from Facebook Graph API
//     final graphResponse = await http.get(Uri.parse(
//         'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=${accessToken.token}'));
//
//     if (graphResponse.statusCode == 200) {
//       return jsonDecode(graphResponse.body);
//     } else {
//       throw Exception('Failed to load user profile');
//     }
//   }
// }
