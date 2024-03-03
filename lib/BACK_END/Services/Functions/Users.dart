import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}