import 'dart:developer';

import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final String documentId; // Change this line
  final bool isAdmin;
  const EditEvent({Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.documentId,
    required this.isAdmin}) : super(key: key); // Change this line

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late Future _getDocument;
  int count = 0;
  late DateTime _selectedDate;
  final _descController = TextEditingController();
  String _selectedEventType = '';
  late List<String> _eventTypes;
  UserStorage storage = UserStorage();
  TapAuth auth = TapAuth();
  @override
  void initState() {

    super.initState();
    _fetchEventTypes().then((types) {
      setState(() {
        _eventTypes = types;
      });
    });
    _getDocument = fetchdocument(widget.documentId);
    _selectedDate = widget.firstDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit")
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _getDocument,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
                fetchCount(snapshot.data['appointmenttype']);
              _descController.text = snapshot.data['description'];
              return _buildForm();
            }
          },
        ),
      ),

    );
  }
  Future<Map<String,dynamic>> fetchdocument(String documentID) async{
    var map = <String,dynamic>{};
    if(widget.isAdmin == true){
      await storage.db.collectionGroup("Church Event").get()
          .then((value) {
            for (var element in value.docs) {
              if(element.id == widget.documentId){
                map = element.data();
              }
            }
          },);
    }
  else{
    await storage.db.collection("users")
        .doc("members")
        .collection(auth.auth.currentUser!.uid)
        .doc("Event")
        .collection("Pending Appointment")
        .get().then((value) {
         for(var element in value.docs) {
           if(element.id == widget.documentId){
             map = element.data();
           }
         }
        },);
    }
  return map;
  }

  Future<String> fetchdisc() async{
    String localdesc = '';
    await storage.db.collection('users')
        .doc('members')
        .collection(auth.auth.currentUser!.uid)
        .doc('Event')
        .collection('Pending Appointment')
        .doc(widget.documentId)
        .get().then((value) {
      localdesc = value.data()?['description'];
    },);
    return localdesc;
  }

  Future<void>fetchCount(String type)async{
      switch(type){
        case "Meeting": {
            count = 0;
        }
        case "Conference": {
          count = 1;
        }
        case "Seminar": {
          count = 2;
        }
        case "Workshop": {
          count = 3;
        }
        case "Webinar": {
          count = 4;
        }
        case "Infant Dedication": {
          count = 5;
        }
        case "Birthday Service": {
          count = 6;
        }
        case "Birthday Manyanita": {
          count = 7;
        }
        case "Membership Certificate": {
          count = 8;
        }
        case "Baptismal Certificate": {
          count = 9;
        }
        default:{
          count = 0;
        }
      }
  }
  
  Widget _buildForm() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
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
          value: _eventTypes[count] ,
          onChanged: (String? newValue) {
            setState(() {
              _selectedEventType = newValue ?? 'Meeting'; //WHY PUT A FUCKING NO VALUE HERE?
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
      List<String> eventTypes = [
        'Meeting',
        'Conference',
        'Seminar',
        'Workshop',
        'Webinar',
        "Infant Dedication",
        'Birthday Service',
        'Birthday Manyanita',
        'Membership Certificate',
        'Baptismal Certificate'

      ];
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
        "appointmenttype": selectedEventType,
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
 // void
}

