import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'appointment_source.dart';


class AddAppointment extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate; // Modify to accept the selected date
  const AddAppointment({Key? key, required this.firstDate, required this.lastDate, required this.selectedDate}) : super(key: key);

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  late DateTime _selectedDate2;
  late TextEditingController _titleController2;
  late TextEditingController _descController2;

  @override
  void initState() {
    super.initState();
    _selectedDate2 = widget.selectedDate ?? DateTime.now();
    _titleController2 = TextEditingController();
    _descController2 = TextEditingController();
  }

  @override
  void dispose() {
    _titleController2.dispose();
    _descController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Appointment")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate2,
            onDateSubmitted: (date) {
              setState(() {
                _selectedDate2 = date;
              });
            },
          ),
          TextField(
            controller: _titleController2,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descController2,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          ElevatedButton(
            onPressed: () {
              _addAppointment(_selectedDate2);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addAppointment(DateTime selectedDate) async {
    final title = _titleController2.text;
    final description = _descController2.text;
    if (title.isEmpty) {
      print('Title cannot be empty');
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in');
      return;
    }

    final AppointmentDocRef = await FirebaseFirestore.instance.collection('appointment').add({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate2),
      "userID": currentUser.uid,
    });

    final appointment = Appointment(
      id: AppointmentDocRef.id,
      title: title,
      description: description,
      date: _selectedDate2,
      userID: currentUser.uid,
    );

    Navigator.pop(context, true);
  }
}






