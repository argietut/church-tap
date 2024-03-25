import 'dart:developer';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TapAuth {
  late String _uid;
  late String _name = '';
  late String _email = '';
  late String _password;
  late String _profilePicture = '';
  late String _token;
  late UserCredential _userCredential;
  User? _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late UserStorage store;



  Future<void> createUserAuth(String name, String email,
      String password,String type) async {
    try {
      _userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.currentUser?.sendEmailVerification();
      _user = _userCredential.user;
      _name = name;
      setRegisterAllDetails();
      if(_user!.uid.length > 4) {
        store = UserStorage();
        store.createUser(_uid,registerUserToFireStore(),type);
      }
    } catch (e) {
      log("ERROR CODE AUTHENTICATION: $e");
    }
  }

  Future<bool> loginUserAuth(String email, String password) async {
    auth.signOut();
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          // Sign out the user if the email is not verified
          await auth.signOut();
          return false; // Account not verified
        } else {
          auth.currentUser?.updatePhotoURL('assets/images/default.png');
          // Proceed to sign in the user since the email is verified
          print(auth.currentUser?.photoURL);
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
    auth.currentUser?.sendEmailVerification();
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






    //get current user ID
    getCurrentUserUID(){
    return auth.currentUser?.uid;
    }

  // Get current user name
  String getCurrentUserName() {
    return _name;
  }

  //para sa  pending appointment
  User? getCurrentUser() {
    return tapAuth.auth.currentUser;
  }

//user profile information
//   String get profilePicture => _profilePicture;
//
//   void setProfilePicture(String url) {
//     _profilePicture = url;
//   }
//
//   Future<void> getCurrentUserInformation() async {
//     _user = auth.currentUser;
//     if (_user != null) {
//       _uid = _user!.uid;
//       _email = _user!.email ?? '';
//       _name = _user!.displayName ?? '';
//       _profilePicture = _user!.photoURL ?? '';
//     }
//   }



}
