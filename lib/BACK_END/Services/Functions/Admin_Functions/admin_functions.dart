import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// admin authentication in firebase
class AdminAuthServices {
  static Future<void> signupAdmin(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);

        await FirebaseFirestore.instance.collection('admins').doc(user.uid).set({
          'name': name,
          'email': email,
          
        });
      }
    } catch (e) {
      throw e; // Rethrow the error for handling in UI
    }
  }

  static Future<void> signinAdmin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e; // Rethrow the error for handling in UI
    }
  }
}


// admin account store to firestore 
class AdminFirestoreServices {
  static Future<void> saveAdmin(String name, String email, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('admins').doc(uid).set({
        'name': name,
        'email': email,
        // Add more admin data fields as needed
      });
    } catch (e) {
      print('Error saving admin data to Firestore: $e');
      // Handle error
      throw e; // Rethrow the error for handling in UI
    }
  }
}