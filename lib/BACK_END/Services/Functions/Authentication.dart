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

  TapAuth(){

  }
  Future<void> createUserAuth(String name, String email,
      String password) async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendUserVerifcationEmail();
      _userCredential.user?.updateDisplayName(name);
      _user = _userCredential.user;
      _name = name;
      setRegisterAllDetails();
      if(_user!.uid.length > 4) {
        store = UserStorage();
        store.createUser(_uid,registerUserToFireStore());
      }
    } catch (e) {
      log("ERROR CODE AUTHENTICATION: $e");
    }
  }

  Future<void> loginUserAuth(String email,String password) async{
     _auth.signOut();
     try{
    _auth.signInWithEmailAndPassword(email: email, password: password);
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      }
      else if(user.emailVerified != true){
        _auth.signOut();
      }
      else {
        print('User is signed in!');
      }
    });
     }catch(e) {
       log("AUTH ERROR : $e");
     }
}

Future<void> sendUserVerifcationEmail() async{
    _auth.currentUser?.sendEmailVerification();
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
