import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Example class to represent an appointment
class Appointment {
  final String id;
  final String date;
  final String details;

  Appointment({required this.id, required this.date, required this.details});
}

// Example class to represent an event
class Event {
  final String id;
  final String date;
  final String details;

  Event({required this.id, required this.date, required this.details});
}

class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  late Stream<List<Appointment>> appointmentStream;
  late Stream<List<Event>> eventStream;

  @override
  void initState() {
    super.initState();
    appointmentStream = FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Appointment(
      id: doc.id,
      details: doc['description'] ?? '',
      date: doc['date'] != null ? (doc['date'] as Timestamp).toDate().toString() : '',
    ))
        .toList());
    eventStream = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Event(
      id: doc.id,
      details: doc['description'] ?? '',
      date: doc['date'] != null ? (doc['date'] as Timestamp).toDate().toString() : '',
    ))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
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
                    // Add sorting functionality here
                  },
                  icon: const Icon(Icons.sort),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Admin Approval",
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
              color: appGreen,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<Appointment>>(
                stream: appointmentStream,
                builder: (context, appointmentSnapshot) {
                  if (appointmentSnapshot.hasError) {
                    return Text('Error fetching appointments: ${appointmentSnapshot.error}');
                  }
                  if (appointmentSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final appointments = appointmentSnapshot.data ?? [];

                  return StreamBuilder<List<Event>>(
                    stream: eventStream,
                    builder: (context, eventSnapshot) {
                      if (eventSnapshot.hasError) {
                        return Text('Error fetching events: ${eventSnapshot.error}');
                      }
                      if (eventSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      final events = eventSnapshot.data ?? [];

                      return ListView(
                        children: [
                          ...appointments.map(
                                (appointment) => ListTile(
                              title: Text(appointment.details),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appointment.date),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(data: appointment, onApprove: (String ) {  },),
                                  ),
                                );
                              },
                            ),
                          ),
                          ...events.map(
                                (event) => ListTile(
                              title: Text(event.details),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.date),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(data: event, onApprove: (String ) {  },),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
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

class DetailsScreen extends StatelessWidget {
  final dynamic data;
  final Function(String) onApprove;

  const DetailsScreen({Key? key, required this.data, required this.onApprove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(data.details),
            SizedBox(height: 20),
            Text(
              'Date:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(data.date),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onApprove(data.id);
                Navigator.pop(context); // Close the details screen after approving
              },
              child: Text('Approve'),
            ),
          ],
        ),
      ),
    );
  }
}
