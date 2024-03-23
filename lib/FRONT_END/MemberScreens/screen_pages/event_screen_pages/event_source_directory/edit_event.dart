import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final String documentId; // Change this line
  const EditEvent({Key? key, required this.firstDate, required this.lastDate, required this.documentId}) : super(key: key); // Change this line

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late DateTime _selectedDate;
  final _descController = TextEditingController();
  String _selectedEventType = '';
  late List<String> _eventTypes;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.firstDate;
    _descController.text = ''; // You may want to clear the text controller initially
    _fetchEventTypes().then((types) {
      setState(() {
        _eventTypes = types;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit Event")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<String>>(
          future: _fetchEventTypes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              _eventTypes = snapshot.data ?? [];
              return _buildForm();
            }
          },
        ),
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
          value: _selectedEventType.isNotEmpty && _eventTypes.contains(_selectedEventType)
              ? _selectedEventType
              : _eventTypes.isNotEmpty
              ? _eventTypes[0] // Use the first item as the initial value
              : '', // If _eventTypes is empty, set an empty string as the initial value
          onChanged: (String? newValue) {
            setState(() {
              _selectedEventType = newValue ?? '';
            });
          },
          items: _eventTypes.map((String value) {
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
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            _updatePendingRequest();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: appGreen2),
          child: const Text("Save",
          style: TextStyle(
            color: appBlack
          ),),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red),
          child: const Text("Cancel",
          style: TextStyle(
            color: appBlack
          ),),
        ),
      ],
    );
  }

  Future<List<String>> _fetchEventTypes() async {
    try {
      // Simulate fetching event types from Firestore
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      List<String> eventTypes = [
        'Meeting',
        'Conference',
        'Seminar',
        'Workshop',
        'Webinar'];
      return eventTypes;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching event types: $e');
      }
      return [];
    }
  }

  Future<void> _updatePendingRequest() async {
    try {
      final description = _descController.text;
      final selectedDate = _selectedDate;
      final selectedEventType = _selectedEventType;

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('No user is currently signed in');
        return;
      }

      final eventDocRef = FirebaseFirestore.instance
          .collection("users")
          .doc("members")
          .collection(currentUser.uid)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(widget.documentId);

      await eventDocRef.update({
        "description": description,
        "date": Timestamp.fromDate(selectedDate),
        "eventType": selectedEventType,
      });

      _showSuccessDialogEventEdit();
    } catch (e) {
      print('Error updating pending request: $e');
    }
  }

  void _showSuccessDialogEventEdit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Pending request updated successfully.'),
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

