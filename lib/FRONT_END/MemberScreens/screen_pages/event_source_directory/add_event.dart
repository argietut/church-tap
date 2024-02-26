import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'event_source.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate; // Modify to accept the selected date
  const AddEvent({Key? key, required this.firstDate, required this.lastDate, required this.selectedDate}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          TextField(
            controller: _titleController,
            maxLines: 1,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descController,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          ElevatedButton(
            onPressed: () {
              _addEvent(_selectedDate);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addEvent(DateTime selectedDate) async {
    final title = _titleController.text;
    final description = _descController.text;
    if (title.isEmpty) {
      print('Title cannot be empty');
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in');
      return;
    }

    final eventDocRef = await FirebaseFirestore.instance.collection('events').add({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
      "userID": currentUser.uid,
    });

    final event = Event(
      id: eventDocRef.id,
      title: title,
      description: description,
      date: _selectedDate,
      userID: currentUser.uid,
    );

    Navigator.pop(context, true);
  }
}






