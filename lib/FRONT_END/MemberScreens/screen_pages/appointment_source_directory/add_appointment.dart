import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late DateTime _selectedDate;
  final _descController = TextEditingController();
  String _selectedAppointmentType = '';
  late List<String> _appointmentType;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _fetchAppointmentTypes().then((types) {
      setState(() {
        _appointmentType = types;
        _selectedAppointmentType = _appointmentType.isNotEmpty ? _appointmentType.first : '';
      });
    });
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Appointment")),
      body: FutureBuilder<List<String>>(
        future: _fetchAppointmentTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _appointmentType = snapshot.data ?? [];
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
          items: _appointmentType.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextField(
          controller: _descController,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        ElevatedButton(
          onPressed: () {
            _addAppointment(_selectedDate);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  Future<List<String>> _fetchAppointmentTypes() async {
    try {
      // Simulate fetching event types from Firestore
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      List<String> appointmentTypes = ['Meeting', 'Conference', 'Seminar', 'Workshop', 'Webinar'];
      return appointmentTypes;
    } catch (e) {
      print('Error fetching appointment types: $e');
      return [];
    }
  }

  void _addAppointment(DateTime selectedDate) async {
    final description = _descController.text;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in');
      return;
    }

    final appointmentDocRef = await FirebaseFirestore.instance.collection('appointments').add({
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
      "userID": currentUser.uid,
      "appointmenttype": _selectedAppointmentType,
    });

    final appointment = Appointment(
      id: appointmentDocRef.id,
      description: description,
      date: _selectedDate,
      userID: currentUser.uid,
      appointmenttype: _selectedAppointmentType,
    );

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Appointment saved successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
