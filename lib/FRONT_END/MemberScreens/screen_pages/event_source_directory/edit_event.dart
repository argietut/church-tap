import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_source.dart'; // Import the Event class

class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final Event event; // Pass the Event object to edit
  const EditEvent({Key? key, required this.firstDate, required this.lastDate, required this.event}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
    _titleController.text = widget.event.title;
    _descController.text = widget.event.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
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
              _updateEvent(_selectedDate);
            },
            child: const Text("Save"),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteEvent();
            },
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _updateEvent(DateTime selectedDate) async {
    final title = _titleController.text;
    final description = _descController.text;
    if (title.isEmpty) {
      print('Title cannot be empty');
      return;
    }

    try {
      await widget.event.updateEvent(
        title: title,
        description: description,
        date: selectedDate,
        userID: widget.event.userID,
      );
      Navigator.pop(context, true); // Notify previous screen that event was updated successfully
    } catch (e) {
      // Handle error
      print('Error updating event: $e');
    }
  }

  void _deleteEvent() async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(widget.event.id).delete();
      Navigator.pop(context, true); // Notify previous screen that event was deleted successfully
    } catch (e) {
      // Handle error
      print('Error deleting event: $e');
    }
  }
}
