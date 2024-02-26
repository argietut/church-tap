import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String userID; // Add userID parameter

  Appointment({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.userID, // Initialize userID parameter
  });

  // Add factory constructor to convert Firestore data to Event object
  factory Appointment.fromFirestore(Map<String, dynamic> data, String id) {
    return Appointment(
      id: id,
      title: data['title'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(),
      userID: data['userID'], // Initialize userID parameter
    );
  }

  // Add method to convert Event object to Firestore data
  Future<void> updateAppointment({
    required String title,
    required String description,
    required DateTime date,
    required String userID, // Pass userID
  }) async {
    try {
      await FirebaseFirestore.instance.collection('appointment').doc(id).update({
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'userID': userID, // Ensure userID is updated
      });
    } catch (e) {
      print('Error updating event: $e');
      rethrow;
    }
  }
}
