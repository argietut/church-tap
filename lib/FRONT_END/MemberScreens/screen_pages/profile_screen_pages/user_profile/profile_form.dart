// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class ProfileForm extends StatefulWidget {
//   final Map<String, dynamic> data;
//   final String uniqueID;
//
//   const ProfileForm({Key? key, required this.data, required this.uniqueID}) : super(key: key);
//
//   @override
//   _ProfileFormState createState() => _ProfileFormState();
// }
//
// class _ProfileFormState extends State<ProfileForm> {
//   late TextEditingController _usernameController;
//
//   @override
//   void initState() {
//     super.initState();
//     _usernameController = TextEditingController(text: widget.data["name"]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Name:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         TextField(
//           controller: _usernameController,
//           decoration: const InputDecoration(
//             hintText: 'Enter your new username',
//           ),
//         ),
//         const SizedBox(height: 16.0),
//         ElevatedButton(
//           onPressed: () => _updateUsername(widget.uniqueID),
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _updateUsername(String uniqueID) async {
//     String newUsername = _usernameController.text.trim();
//     if (newUsername.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc("members")
//             .collection(uniqueID)
//             .doc("About User")
//             .update({"name": newUsername});
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Username updated successfully')),
//         );
//       } catch (error) {
//         print('Error updating username: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to update username')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Username cannot be empty')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     super.dispose();
//   }
// }