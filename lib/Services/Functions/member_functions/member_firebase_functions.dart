import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestoreServices {
  static Future<void> saveUser(String name, String email, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        // Add more user data fields as needed
      });
    } catch (e) {
      print('Error saving user data to Firestore: $e');
      // Handle error
      throw e; // Rethrow the error for handling in UI
    }
  }
}