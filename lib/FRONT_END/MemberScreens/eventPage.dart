import 'dart:developer';

import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final TapAuth tapAuth = TapAuth();
  late Stream<QuerySnapshot> _pendingAppointmentsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  Future<void> _initializeStream() async {
    try {
      final currentUser = tapAuth.getCurrentUser();
      if (currentUser != null) {
        _pendingAppointmentsStream = UserStorage()
            .fetchPendingAppointments(currentUser.uid);
      } else {
        throw ArgumentError("Current user not found.");
      }
    } catch (e) {
      log("Error initializing stream: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_pendingAppointmentsStream == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle sorting action
                  },
                  icon: const Icon(Icons.sort),
                ),
                const Text(
                  "Events",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.green,
            ),
            const SizedBox(height: 15),


            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _pendingAppointmentsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No pending appointments found.'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((
                        DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      Timestamp timeStamp = data["date"];
                      DateTime dateTime = timeStamp.toDate();

                      return Card(
                        color: Colors.amber.shade200,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: ListTile(
                          title: const Text(
                            'Pending Requests: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Appointment type: ${data['appointmenttype'] ?? ''}',
                              ),
                              Text(
                                'Description: ${data['description'] ?? ''}',
                              ),
                              Text(
                                'Date and Time: ${ dateTime.month} ' + '${dateTime.day}' + ' , '+'${ dateTime.year}',
                              ),

                            ],
                          ),
                         trailing:  IconButton(
                           icon: Icon(Icons.info),
                           onPressed: () {

                           },
                         ),

                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


