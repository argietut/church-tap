import 'package:cloud_firestore/cloud_firestore.dart';

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