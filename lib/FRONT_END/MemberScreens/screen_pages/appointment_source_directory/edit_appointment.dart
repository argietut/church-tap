import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late DateTime _selectedDate;
  final _descController2 = TextEditingController();
  String _selectedAppointmentType = '';
  late List<String> _appointmentTypes;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.appointment.date;
    _descController2.text = widget.appointment.description;
    _fetchAppointmentTypes().then((types) {
      setState(() {
        _appointmentTypes = types;
        _selectedAppointmentType = types.contains(widget.appointment.appointmenttype) ? widget.appointment.appointmenttype : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Appointment")),
      body: FutureBuilder<List<String>>(
        future: _fetchAppointmentTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
          initialDate: _selectedDate,
          onDateSubmitted: (date) {
            setState(() {
              _selectedDate = date;
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
            _updateAppointment(_selectedDate);
            _showSuccessDialogAppointmentEdit();
          },
          child: const Text("Save"),
        ),
        ElevatedButton(
          onPressed: () {
            _deleteAppointment();
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Future<List<String>> _fetchAppointmentTypes() async {
    try {
      // Simulate fetching event types from Firestore
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      List<String> appointmenttype = ['Meeting', 'Conference', 'Seminar', 'Workshop', 'Webinar'];
      return appointmenttype;
    } catch (e) {
      print('Error fetching appointment types: $e');
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

    setState(() {
      _selectedDate = selectedDate;
      _selectedAppointmentType = _selectedAppointmentType; // Make sure the selected appointment type is updated
    });

    final AppointmentDocRef = FirebaseFirestore.instance.collection('appointments').doc(widget.appointment.id);

    try {
      await AppointmentDocRef.update({
        "description": description,
        "date": Timestamp.fromDate(_selectedDate),
        "appointmenttype": _selectedAppointmentType,
      });

      _showSuccessDialog("Appointment updated successfully.");

      // Refresh the screen
      Navigator.pop(context, true);
    } catch (e) {
      // Handle error
      print('Error updating appointment: $e');
    }
  }




  void _deleteAppointment() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Cancel Appointment"),
        content: const Text("Are you sure you want to cancel this event?"),
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
                await FirebaseFirestore.instance.collection('appointments').doc(widget.appointment.id).delete();

                // Show success message dialog

                // Refresh the screen
                Navigator.pop(context);
                Navigator.pop(context, true); // Pass true to indicate event was deleted successfully
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Success"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
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
