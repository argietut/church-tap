// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'event_source.dart';
//
// class AddEvent extends StatefulWidget {
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final DateTime selectedDate; // Modify to accept the selected date
//   const AddEvent({Key? key, required this.firstDate, required this.lastDate, required this.selectedDate}) : super(key: key);
//
//   @override
//   State<AddEvent> createState() => _AddEventState();
// }
//
// class _AddEventState extends State<AddEvent> {
//   late DateTime _selectedDate;
//   final _descController = TextEditingController();
//   String _selectedEventType = '';
//   late List<String> _eventTypes;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.selectedDate;
//     _fetchEventTypes().then((types) {
//       setState(() {
//         _eventTypes = types;
//         _selectedEventType = _eventTypes.isNotEmpty ? _eventTypes.first : '';
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _descController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Event")),
//       body: FutureBuilder<List<String>>(
//         future: _fetchEventTypes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             _eventTypes = snapshot.data ?? [];
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
//           firstDate: widget.firstDate,
//           lastDate: widget.lastDate,
//           initialDate: _selectedDate,
//           onDateSubmitted: (date) {
//             setState(() {
//               _selectedDate = date;
//             });
//           },
//         ),
//         DropdownButtonFormField<String>(
//           value: _selectedEventType,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedEventType = newValue!;
//             });
//           },
//           items: _eventTypes.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         TextField(
//           controller: _descController,
//           maxLines: 5,
//           decoration: const InputDecoration(labelText: 'Description'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             _addEvent(_selectedDate);
//           },
//           child: const Text("Save"),
//         ),
//       ],
//     );
//   }
//
//   Future<List<String>> _fetchEventTypes() async {
//     try {
//       // Simulate fetching event types from Firestore
//       await Future.delayed(Duration(seconds: 1)); // Simulate network delay
//       List<String> eventTypes = ['Meeting', 'Conference', 'Seminar', 'Workshop', 'Webinar'];
//       return eventTypes;
//     } catch (e) {
//       print('Error fetching event types: $e');
//       return [];
//     }
//   }
//
//   void _addEvent(DateTime selectedDate) async {
//     final description = _descController.text;
//
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       print('No user is currently signed in');
//       return;
//     }
//
//     final eventDocRef = await FirebaseFirestore.instance.collection('events').add({
//       "description": description,
//       "date": Timestamp.fromDate(_selectedDate),
//       "userID": currentUser.uid,
//       "eventType": _selectedEventType,
//     });
//
//     final event = Event(
//       id: eventDocRef.id,
//       description: description,
//       date: _selectedDate,
//       userID: currentUser.uid,
//       eventType: _selectedEventType,
//     );
//     _showSuccessDialogEvent();
//   }
//
//   void _showSuccessDialogEvent() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Success'),
//           content: Text('Event saved successfully.'),
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
