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

  Future<bool> loginUserAuth(String email, String password) async {
    _auth.signOut();
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          // Sign out the user if the email is not verified
          await _auth.signOut();
          return false; // Account not verified
        } else {
          // Proceed to sign in the user since the email is verified
          return true; // Account verified
        }
      } else {
        // User not found
        return false;
      }
    } catch (e) {
      print("AUTH ERROR : $e");
      return false; // Login failed
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

    //error snack bar sa login
  bool isEmailVerified() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Check if the user is logged in and their email is verified
      return currentUser.emailVerified;
    } else {
      // If the user is not logged in, return false
      return false;
    }
  }

}
