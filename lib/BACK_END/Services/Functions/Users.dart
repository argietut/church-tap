import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStorage {
  //TODO write database for all users
  final FirebaseFirestore db = FirebaseFirestore.instance;


  Future<void> createUser(String uniqueID,
      Map<String, String> userInformation) async {
    try {
      db.collection("users")
          .doc("members")
          .collection(uniqueID)
          .doc("About User")
          .set(userInformation);
    }
    catch (e) {
      log("Error code STORAGE: $e");
    }
  }

  Future<void> createMemberEvent(String uniqueID, Map<String, dynamic> dateTime,
      String event) async {
    try {
      db.collection("users")
          .doc("members")
          .collection(uniqueID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc().set(dateTime);
    } catch (e) {
      log("Error code STORAGE: $e");
    }
  }


  Future<List<int>> getPendingDate(String uniqueID) async {
    List<int> documents = [];
    await db.collection("users")
        .doc("members")
        .collection(uniqueID)
        .doc("Event")
        .collection("Pending Appointment")
        .get()
        .then((value) {
      for (var element in value.docs) {
        Timestamp t = element.data()["date"];
        DateTime dats = t.toDate();
        documents.add(dats.day);
      }
    });
    return documents;
  }

  Stream<QuerySnapshot> fetchPendingAppointments(String uniqueID) {
    return db
        .collection("users")
        .doc("members")
        .collection(uniqueID)
        .doc("Event")
        .collection("Pending Appointment")
        .snapshots();
  }


  Future<List<Map<String, dynamic>>> getAllPendingAppointmentsForMember(String memberId) async {
    List<Map<String, dynamic>> pendingAppointments = [];
    try {
      QuerySnapshot querySnapshot = await db
          .collection("users")
          .doc("members")
          .collection(memberId)
          .doc("Event")
          .collection("Pending Appointment")
          .get();
      querySnapshot.docs.forEach((document) {
        Map<String, dynamic> appointmentData = document.data() as Map<String, dynamic>;

        appointmentData['documentId'] = document.id;
        pendingAppointments.add(appointmentData);
      });
    } catch (e) {
      log("Error fetching pending appointments for member $memberId: $e");
    }
    return pendingAppointments;
  }

}