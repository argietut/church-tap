import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  final _descController = TextEditingController();
  String _selectedEventType = '';
  late List<String> _eventTypes;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.event.date;
    _descController.text = widget.event.description;
    _fetchEventTypes().then((types) {
      setState(() {
        _eventTypes = types;
        _selectedEventType =
        types.contains(widget.event.eventType) ? widget.event.eventType : '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Event")),
      body: FutureBuilder<List<String>>(
        future: _fetchEventTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _eventTypes = snapshot.data ?? [];
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
          value: _selectedEventType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedEventType = newValue!;
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
        ElevatedButton(
          onPressed: () {
            _updateEvent(_selectedDate);
            _showSuccessDialogEventEdit();
          },
          child: const Text("Save"),

        ),
        ElevatedButton(
          onPressed: () {
            _deleteEvent();
          },
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: const Text("Cancel"),
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
        'Webinar'
      ];
      return eventTypes;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching event types: $e');
      }
      return [];
    }
  }

  Future<void> _updateEvent(DateTime selectedDate) async {
    final description = _descController.text;

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user is currently signed in');
      return;
    }

    final eventDocRef = FirebaseFirestore.instance.collection('events').doc(
        widget.event.id);

    await eventDocRef.update({
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
      "eventType": _selectedEventType,
    });



  }

  void _deleteEvent() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm cancel event"),
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
                await FirebaseFirestore.instance.collection('events').doc(widget.event.id).delete();

                // Show success message dialog

                // Refresh the screen
                Navigator.pop(context);
                Navigator.pop(context, true); // Pass true to indicate event was deleted successfully
              } catch (e) {
                // Handle error
                if (kDebugMode) {
                  print('Error cancel event: $e');
                }
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }




  void _showSuccessDialogEventEdit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Event updated successfully.'),
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


