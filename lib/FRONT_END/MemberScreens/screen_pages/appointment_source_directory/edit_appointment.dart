
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'appointment_source.dart';


class EditAppointment extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final Appointment appointment; // Pass the Event object to edit
  const EditAppointment({Key? key, required this.firstDate, required this.lastDate, required this.appointment}) : super(key: key);

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  late DateTime _selectedDate2;
  final _titleController2 = TextEditingController();
  final _descController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate2 = widget.appointment.date;
    _titleController2.text = widget.appointment.title;
    _descController2.text = widget.appointment.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Appointment")),
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
              _updateAppointment(_selectedDate2);
            },
            child: const Text("Save"),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteAppointment();
            },
            style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _updateAppointment(DateTime selectedDate) async {
    final title = _titleController2.text;
    final description = _descController2.text;
    if (title.isEmpty) {
      print('Title cannot be empty');
      return;
    }

    try {
      await widget.appointment.updateAppointment(
        title: title,
        description: description,
        date: selectedDate,
        userID: widget.appointment.id,
      );
      Navigator.pop(context, true); // Notify previous screen that event was updated successfully
    } catch (e) {
      // Handle error
      print('Error updating event: $e');
    }
  }

  void _deleteAppointment() async {
    try {
      await FirebaseFirestore.instance.collection('appointment').doc(widget.appointment.id).delete();
      Navigator.pop(context, true); // Notify previous screen that event was deleted successfully
    } catch (e) {
      // Handle error
      print('Error deleting event: $e');
    }
  }
}
