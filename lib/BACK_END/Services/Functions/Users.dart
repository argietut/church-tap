import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserStorage {
  //TODO write database for all users
  final FirebaseFirestore db = FirebaseFirestore.instance;


  Future<void> createUser(String uniqueID,
      Map<String, String> userInformation, String type) async {
    try {
      db.collection("users")
          .doc(type)
          .collection(uniqueID)
          .doc("About User")
          .set(userInformation);
    }
    catch (e) {
      log("Error code STORAGE: $e");
    }
  }


  Future<void> createMemberEvent(String uniqueID, Map<String, dynamic> dateTime,
      String type) async {
    try {
      if (type == "members") {
        db.collection("users")
            .doc("members")
            .collection(uniqueID)
            .doc("Event")
            .collection("Pending Appointment")
            .doc().set(dateTime);
      }
      else {
        db.collection("users")
            .doc("admins")
            .collection(uniqueID)
            .doc("Event")
            .collection("Church Event")
            .doc().set(dateTime);
      }
    } catch (e) {
      log("Error code STORAGE: $e");
    }
  }

  Future<List<DateTime>> getApprovedDate(String uid, String type) async {
    List<DateTime> documents = [];
    try {
      if (type == "members") {
        await db.collection("users")
            .doc("members")
            .collection(uid)
            .doc("Event")
            .collection("Approved Appointment")
            .get()
            .then((value) {
          for (var element in value.docs) {
            Timestamp t = element.data()["date"];
            DateTime dats = t.toDate();
            documents.add(dats);
          }
        });
      }
      else {
        await db.collectionGroup("Church Event")
            .get()
            .then((value) {
          for (var element in value.docs) {
            Timestamp t = element.data()["date"];
            DateTime dats = t.toDate();
            documents.add(dats);
          }
        });
      }
    }
    catch (e) {

    }
    return documents;
  }

  Future<List<DateTime>> getPendingDate(String uid) async {
    List<DateTime> documents = [];
    await db.collection("users")
        .doc("members")
        .collection(uid)
        .doc("Event")
        .collection("Pending Appointment")
        .get()
        .then((value) {
      for (var element in value.docs) {
        Timestamp t = element.data()["date"];
        DateTime dats = t.toDate();
        documents.add(dats);
      }
    });
    return documents;
  }

  Future<void> setDisableDay(Map<String, dynamic> dateTime, String uid) async {
    try {
      db.collection("users")
          .doc("admins")
          .collection(uid)
          .doc("Event")
          .collection("Disabled Days")
          .doc()
          .set(dateTime);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> unsetDisableDay(int day, int month, int year) async {
    db.collectionGroup("Disabled Days")
        .get()
        .then((value) {
      for (var element in value.docs) {
        var a = element.data()['date'];
        Timestamp timestamp = a;
        DateTime dateTime = timestamp.toDate();
        if (dateTime.day == day && dateTime.month == month &&
            dateTime.year == year) {
          db.runTransaction((Transaction transaction) async {
            transaction.delete(element.reference);
          },);
          // Remove Break due to duplicate disabled dates
        }
        else {
          continue;
        }
      }
    },);
  }

  Future<List<DateTime>> getDisableDay() async {
    List<DateTime> documents = [];
    try {
      await db.collectionGroup("Disabled Days")
          .get()
          .then((value) {
        for (var element in value.docs) {
          Timestamp t = element.data()["date"];
          DateTime dats = t.toDate();
          documents.add(dats);
        }
      },);
    } catch (e) {}
    return documents;
  }

  Stream<QuerySnapshot> fetchPendingAppointments(String uid) {
    return db
        .collection("users")
        .doc("members")
        .collection(uid)
        .doc("Event")
        .collection("Pending Appointment")
        .snapshots();
  }


  Stream<QuerySnapshot> fetchAllPendingAppointments() {
    return db
        .collectionGroup("Pending Appointment")
        .snapshots();
  }

  Stream<QuerySnapshot> fetchApprovedAppointments(String uid) {
    return db
        .collection("users")
        .doc("members")
        .collection(uid)
        .doc("Event")
        .collection("Approved Appointment")
        .snapshots();
  }

  Stream<QuerySnapshot> fetchAllApprovedAppointments() {
    return db
        .collectionGroup("Approved Appointment")
        .snapshots();
  }

  Future<void> approvedAppointment(String userID, String appointmentId) async {
    try {
      DocumentSnapshot appointmentDoc = await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .get();

      // Update status field to 'Approved'
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .update({'status': 'Approved'});

      await setNotification(userID, appointmentId);
      // Move appointment to 'Approved Appointment' collection
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Approved Appointment")
          .doc(appointmentId) // Use the same appointmentId
          .set(appointmentDoc.data() as Map<String, dynamic>);

      // Delete from 'Pending Appointment' collection
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .delete();
    } catch (e) {
      log("Error approving appointment: $e");
    }
  }

  Future<void> denyAppointment(String userID, String appointmentId) async {
    try {
      DocumentSnapshot appointmentDoc = await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .get();

      // Update status field to 'Denied'
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .update({'status': 'Denied'});
      await setNotification(userID, appointmentId);

      // Move appointment to 'Denied Appointment' collection
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Denied Appointment")
          .doc(appointmentId)
          .set(appointmentDoc.data() as Map<String, dynamic>);

      // Delete from 'Pending Appointment' collection
      await db
          .collection("users")
          .doc("members")
          .collection(userID)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(appointmentId)
          .delete();
    } catch (e) {
      log("Error denying appointment: $e");
    }
  }


  Stream<QuerySnapshot> fetchDenyAppointment() {
    return db
        .collectionGroup("Denied Appointment")
        .snapshots();
  }


  Stream<QuerySnapshot> fetchCreateMemberEvent() {
    return db
        .collectionGroup("Church Event")
        .snapshots();
  }

  Future<void> setNotification(String uid, String appointmentId) async {
    DocumentSnapshot documentSnapshot = await db
        .collection("users")
        .doc("members")
        .collection(uid)
        .doc("Event")
        .collection("Pending Appointment")
        .doc(appointmentId)
        .get();
    await db.
    collection("users")
        .doc('members')
        .collection(uid)
        .doc('Event')
        .collection('Notification')
        .doc(appointmentId)
        .set(documentSnapshot.data() as Map<String, dynamic>);
  }

  Stream<QuerySnapshot> getNotification(String uid) {
    return db
        .collection('users')
        .doc('members')
        .collection(uid)
        .doc('Event')
        .collection('Notification')
        .snapshots();
  }

  Future<bool> checkAdmin(String uid) async {
    bool a = false;
    var test = db.collection('users')
        .doc('admins').get();
    test.then((value) {
      if (uid == value.id) {
        a = true;
      }
      else {
        a = false;
      }
    },);
    return a;
  }

  Future<bool> checkAdmins(String uid) async {
    bool check = false;
    await db.collection('users').doc('admins').collection(uid).get().then((
        value) {
      if (value.size > 0) {
        check = true;
      }
      else {
        check = false;
      }
    },);
    return check;
  }

  Future<void> deleteOldDates() async{
  //disabled Days
   db.collectionGroup('Church Event').where('date',isLessThan: DateTime.now()).get().then((value) {
     value.docs.clear();
   },);
  }
}