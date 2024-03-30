// import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AddEventChurch extends StatefulWidget {
//   final DateTime firstDate3;
//   final DateTime lastDate3;
//   final DateTime selectedDate3; // Modify to accept the selected date
//   const AddEventChurch(
//       {Key? key,
//         required this.firstDate3,
//         required this.lastDate3,
//         required this.selectedDate3,
//         required String churchEvent})
//       : super(key: key);
//
//   @override
//   State<AddEventChurch> createState() => _AddEventChurchState();
// }
//
// class _AddEventChurchState extends State<AddEventChurch> {
//   late DateTime _selectedDate3;
//   final _descController3 = TextEditingController();
//   String _selectedChurchEventType = '';
//   late List<String> _churchEventTypes;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate3 = widget.selectedDate3;
//     _fetchEventChurchTypes().then((types) {
//       setState(() {
//         _churchEventTypes = types;
//         _selectedChurchEventType =
//         _churchEventTypes.isNotEmpty ? _churchEventTypes.first : '';
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _descController3.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create Church Event"),
//       ),
//       body: FutureBuilder<List<String>>(
//         future: _fetchEventChurchTypes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             _churchEventTypes = snapshot.data ?? [];
//             return _buildForm();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildForm() {
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: [
//         InputDatePickerFormField(
//           firstDate: widget.firstDate3,
//           lastDate: widget.lastDate3,
//           initialDate: _selectedDate3,
//           onDateSubmitted: (date) {
//             setState(() {
//               _selectedDate3 = date;
//             });
//           },
//         ),
//         DropdownButtonFormField<String>(
//           value: _selectedChurchEventType,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedChurchEventType = newValue!;
//             });
//           },
//           items: _churchEventTypes.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         TextField(
//           controller: _descController3,
//           maxLines: 5,
//           decoration: const InputDecoration(labelText: 'Description'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             _addEvent(_selectedDate3);
//           },
//           child: const Text("Save"),
//         ),
//       ],
//     );
//   }
//
//   Future<List<String>> _fetchEventChurchTypes() async {
//     // Simulate fetching event types from somewhere
//     await Future.delayed(Duration(microseconds: 100)); // Simulate network delay
//     List<String> eventTypes = ['Meeting', 'Conference', 'Seminar', 'Workshop', 'Webinar'];
//     return eventTypes;
//   }
//
//   void _addEvent(DateTime selectedDate) async {
//     final description = _descController3.text;
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       print('No user is currently signed in');
//       return;
//     }
//
//
//     await UserStorage().createAdminEvent(
//       currentUser.uid,
//       {
//         "description": description,
//         "date": Timestamp.fromDate(_selectedDate3),
//         "ChurchEventType": _selectedChurchEventType,
//       },
//       "Church Event", // Specify the event type as "Church Event"
//     );
//
//     _showSuccessDialogEvent(context);
//   }
//
//   void _showSuccessDialogEvent(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Success'),
//           content: Text('Church Event saved successfully.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pop(context, true);
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
