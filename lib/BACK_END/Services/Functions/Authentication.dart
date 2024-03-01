import 'dart:developer';

import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TapAuth {
  late String _uid;
  late String _name;
  late String _email;
  late String _password;
  late String _profilePicture;
  late String _token;
  late UserCredential _userCredential;
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserStorage store;

  Future<void> createUserAuth(String name, String email,
      String password) async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = _userCredential.user;
      _name = name;
      setRegisterAllDetails();
      print("EYYY $_uid");
      if(_user!.uid.length > 4) {
        store = UserStorage();
        store.createUser(_uid,registerUserToFireStore());
      }
    } catch (e) {
      log("ERROR CODE AUTHENTICATION: $e");
    }
  }

    void setRegisterAllDetails() {
      _uid = _user!.uid;
      _email = _user!.email!;
    }

    setid(){
    _uid = _user!.uid;
    }

//CAREFUL USING THIS!
    String getUniqueID() {
      return _uid;
    }

    String getUsername() {
      return _name;
    }

    getEmail() {
      return _email;
    }
    registerUserToFireStore() {
      var user_full_details = <String, String>{
        "name": getUsername(),
        "email": getEmail(),
        "Unique ID": getUniqueID()
      };
      return user_full_details;
    }
}
