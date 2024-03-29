// import 'dart:async';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// abstract class UserStorage {
//   Future<void> approvedAppointment(String userID, String appointmentId);
//   Future<void> denyAppointment(String userID, String appointmentId);
//   Stream<QuerySnapshot> fetchAllPendingAppointments();
// // Add any other abstract methods or properties here
// }
//
// // Concrete implementation of UserStorage
// class ConcreteUserStorage extends UserStorage {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   @override
//   Future<void> approvedAppointment(String userID, String appointmentId) async {
//     try {
//       // Implementation for approving appointment
//     } catch (e) {
//       log("Error approving appointment: $e");
//     }
//   }
//
//   @override
//   Future<void> denyAppointment(String userID, String appointmentId) async {
//     try {
//       // Implementation for denying appointment
//     } catch (e) {
//       log("Error denying appointment: $e");
//     }
//   }
//
//   @override
//   Stream<QuerySnapshot> fetchAllPendingAppointments() {
//     // Implementation for fetching all pending appointments
//     return db.collection("pending_appointments").snapshots();
//   }
//
//
// }
