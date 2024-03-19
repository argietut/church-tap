import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserStorage {
  //TODO write database for all users
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> createUser(String uniqueID,Map<String,String> userInformation) async{
    try{
      db.collection("users").doc("members").collection(uniqueID).doc("About User").set(userInformation);
    }
    catch(e){
      log("Error code STORAGE: $e");
    }
  }

  Future<void> createMemberEvent(String uniqueID,Map<String,dynamic> dateTime,String event) async {
    try{
      db.collection("users").doc("members").collection(uniqueID).doc("Event").collection("Pending Appointment").doc().set(dateTime);
    }catch(e){
      log("Error code STORAGE: $e");
    }
  }

 Future<List> getPendingDate(String uniqueID) async {
    List<int> documents = [];
     await db.collection("users").doc("members").collection(uniqueID).doc("Event").collection("Pending Appointment")
        .get().then((value) {
          for (var element in value.docs) {
            Timestamp t = element.data()["date"];
            DateTime dats = t.toDate();
            documents.add(dats.day);
          }
        });
    return documents;
  }
  //TODO check if admin or not
/*Future<bool> isAdmin(String uid) async{
    try{
     var holder = await db.collection("users").doc("admins").collection(uid).doc("About User")
         .get().then((value){
           if()
     });
    }
    catch(e){
      log("Error code STORAGE: $e");
    }
    return true;

}*/
}