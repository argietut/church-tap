// import 'dart:async';
// import 'package:bethel_app_final/widgets/navigation_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({Key? key, required User user}): super(key: key);

//   @override
//   State<VerificationScreen> createState() =>
//       _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   final auth = FirebaseAuth.instance;
//   late User user;
//   late Timer timer; // Change Time to Timer

//   @override
//   void initState() {
//     user = auth.currentUser!;
//     user.sendEmailVerification();

//     timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       checkEmailVerified();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer.cancel(); // Change cencel() to cancel()
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verification')),
//       body: Center(
//         child: Text(
//           'An email has been sent to ${user.email} for verification. Please check your email.',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }

//   Future<void> checkEmailVerified() async {
//     user = auth.currentUser!;
//     await user.reload();
//     if (user.emailVerified) {
//       timer.cancel();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     }
//   }
// }
