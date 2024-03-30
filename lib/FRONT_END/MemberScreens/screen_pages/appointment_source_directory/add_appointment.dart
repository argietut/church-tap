import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddAppointment extends StatefulWidget {
  final String type;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate; // Modify to accept the selected date
  const AddAppointment({Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.type}) : super(key: key);


  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  late TapAuth tapAuth;
  late UserStorage userStorage;
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
      appBar: AppBar(
          title: const Text(
              "Add Appointment")
      ),
      body: FutureBuilder<List<String>>(
        future: _fetchAppointmentTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            );
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
      /*  InputDatePickerFormField(
          errorInvalidText: "Date is not valid ",
          errorFormatText: "Date is not in a Correct Format",
          acceptEmptyDate: false,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          initialDate: _selectedDate,
          onDateSubmitted: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),*/
        TextFormField( //USED THIS KAY PARA WALAY BROKEN DATES UG YEARS SA DATABASE
          enabled: false,
          readOnly: true,
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only()
              ),
              enabled: false,
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black)
              )
          ),
          style: TextStyle(
              color: Colors.black),
          initialValue: "${_selectedDate.month}"+"/${_selectedDate.day}/"+"${_selectedDate.year}",
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
      List<String> appointmentTypes = ['Meeting', 'Conference', 'Seminar', 'Workshop', 'Webinar'];
      return appointmentTypes;
    } catch (e) {
      print('Error fetching appointment types: $e');
      return [];
    }
}
// DEPRECATED
  void _addAppointment(DateTime selectedDate) async {
    tapAuth = TapAuth();
    userStorage = UserStorage();
    final description = _descController.text;
    if (tapAuth.getCurrentUserUID() == null) {
      print('No user is currently signed in');
      return;
    }

    var page = <String, dynamic>{
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
      "userID": tapAuth.getCurrentUserUID(),
      "appointmenttype": _selectedAppointmentType,
      "name" : tapAuth.auth.currentUser!.displayName,
      "email" : tapAuth.auth.currentUser!.email
    };

    userStorage.createMemberEvent(tapAuth.getCurrentUserUID(), page, widget.type);

/*    final appointment = Appointment(
      id: appointmentDocRef.id,
      description: description,
      date: _selectedDate,
      userID: currentUser.uid,
      appointmenttype: _selectedAppointmentType,
    );*/

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
              //  Navigator.pushReplacement(context, newRoute)
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
