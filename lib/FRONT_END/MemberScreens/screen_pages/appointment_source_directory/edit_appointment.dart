
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  final _descController2 = TextEditingController();
  String _selectedAppointmentType = '';
  late List<String> _appointmentTypes;

  @override
  void initState() {
    super.initState();
    _selectedDate2 = widget.appointment.date;
    _descController2.text = widget.appointment.description;
    _fetchEventTypes().then((types) {
      setState(() {
        _appointmentTypes = types;
        _selectedAppointmentType =
        types.contains(widget.appointment.appointmenttype) ? widget.appointment.appointmenttype : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Appointment")),
      body: FutureBuilder<List<String>>(
        future: _fetchEventTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _appointmentTypes = snapshot.data ?? [];
            return _buildForm();
          }
        },
      ),
    );
  }

  Widget _buildForm() {
    return ListView(
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
        DropdownButtonFormField<String>(
          value: _selectedAppointmentType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedAppointmentType = newValue!;
            });
          },
          items: _appointmentTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextField(
          controller: _descController2,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        ElevatedButton(
          onPressed: () {
            _updateAppointment(_selectedDate2);
            _showSuccessDialogAppointmentEdit();
          },
          child: const Text("Save"),

        ),
        ElevatedButton(
          onPressed: () {
            _deleteAppointment();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Future<List<String>> _fetchEventTypes() async {
    try {
      // Simulate fetching event types from Firestore
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      List<String> appointmentType = [
        'Meeting',
        'Conference',
        'Seminar',
        'Workshop',
        'Webinar'
      ];
      return appointmentType;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching appointment types: $e');
      }
      return [];
    }
  }

  Future<void> _updateAppointment(DateTime selectedDate) async {
    final description = _descController2.text;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in');
      return;
    }

    final eventDocRef = FirebaseFirestore.instance.collection('appointments').doc(
        widget.appointment.id);

    await eventDocRef.update({
      "description": description,
      "date": Timestamp.fromDate(_selectedDate2),
      "appointmentType": _selectedAppointmentType,
    });



  }

  void _deleteAppointment() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("Confirm Cancel Appointment"),
            content: const Text(
                "Are you sure you want to cancel this Appointment?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance.collection('appointments')
                        .doc(widget.appointment.id)
                        .delete();

                    // Show success message dialog

                    // Refresh the screen
                    Navigator.pop(context);
                    Navigator.pop(context,
                        true); // Pass true to indicate event was deleted successfully
                  } catch (e) {
                    // Handle error
                    if (kDebugMode) {
                      print('Error cancel appointment: $e');
                    }
                  }
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
  void _showSuccessDialogAppointmentEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Appointment updated successfully.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context, true);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
    );
  }
}
