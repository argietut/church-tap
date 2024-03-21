import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'church_event_source.dart';


class EditChurchEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final ChurchEvent churchEvent;
  const EditChurchEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.churchEvent,
  }) : super(key: key);

  @override
  State<EditChurchEvent> createState() => _EditChurchEventState();
}

class _EditChurchEventState extends State<EditChurchEvent> {
  late DateTime _selectedDate;
  final _descController = TextEditingController();
  String _selectedEventType = '';
  late List<String> _eventTypes;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.churchEvent.date;
    _descController.text = widget.churchEvent.description;
    _selectedEventType = widget.churchEvent.churchEventType;
    _fetchEventTypes().then((types) {
      setState(() {
        _eventTypes = types;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Church Event")),
      body: FutureBuilder<List<String>>(
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
            _updateChurchEvent(_selectedDate);
            _showSuccessDialogEventEdit();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  Future<List<String>> _fetchEventTypes() async {
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
  }

  Future<void> _updateChurchEvent(DateTime selectedDate) async {
    final description = _descController.text;

    try {
      await FirebaseFirestore.instance
          .collection('churchEvent')
          .doc(widget.churchEvent.id)
          .update({
        "description": description,
        "date": Timestamp.fromDate(selectedDate),
        "churchEventType": _selectedEventType,
      });
    } catch (e) {
      print('Error updating church event: $e');
    }
  }

  void _showSuccessDialogEventEdit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Church event updated successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
