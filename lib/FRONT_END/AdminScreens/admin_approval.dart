import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Updated Appointment class
class Appointment {
  final String id;
  final String appointmenttype;
  final Timestamp date;
  final String description;
  final String userID;

  Appointment({
    required this.id,
    required this.appointmenttype,
    required this.date,
    required this.description,
    required this.userID,
  });
}

// Updated Event class
class Event {
  final String id;
  final String eventType;
  final Timestamp date;
  final String description;
  final String userID;

  Event({
    required this.id,
    required this.eventType,
    required this.date,
    required this.description,
    required this.userID,
  });
}

// Existing Event class (unchanged)

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
      appointmenttype: doc['appointmenttype'] ?? '',
      date: doc['date'],
      description: doc['description'] ?? '',
      userID: doc['userID'] ?? '',
    ))
        .toList());

    eventStream = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Event(
      id: doc.id,
      eventType: doc['eventType'] ?? '',
      date: doc['date'],
      description: doc['description'] ?? '',
      userID: doc['userID'] ?? '',
    ))
        .toList());


  }

  Future<void> approveAppointment(Appointment appointment) async {
    final approvedAppointmentsCollection =
    FirebaseFirestore.instance.collection('approved_appointments');
    final appointmentData = {
      'appointmenttype': appointment.appointmenttype,
      'date': appointment.date,
      'description': appointment.description,
      'userID': appointment.userID,
    };

    try {
      await approvedAppointmentsCollection.add(appointmentData);
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .delete();
      print('Approved appointment added successfully');
    } catch (e) {
      print('Error adding approved appointment: $e');
    }
  }

  Future<void> approveEvent(Event event) async {
    final approvedEventsCollection =
    FirebaseFirestore.instance.collection('approved_events');
    final eventData = {
      'eventType': event.eventType,
      'date': event.date,
      'description': event.description,
      'userID': event.userID,
    };

    try {
      await approvedEventsCollection.add(eventData);
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .delete();
      print('Approved event added successfully');
    } catch (e) {
      print('Error adding approved event: $e');
    }
  }

  Future<void> declineAppointment(Appointment appointment) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .delete();
      print('Appointment declined and removed');
    } catch (e) {
      print('Error declining appointment: $e');
    }
  }

  Future<void> declineEvent(Event event) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .delete();
      print('Event declined and removed');
    } catch (e) {
      print('Error declining event: $e');
    }
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

           /*   sortingButton.buildIconButton(onPressed: () {
                // Handle sorting logic here
                sortingButton.toggleSortingOption();
                // Implement sorting logic here based on sortingButton.currentSortingOption
                if (sortingButton.currentSortingOption == ApprovalSortingOption.Month) {
                  // Sort by month
                  // Your sorting logic here...
                } else {
                  // Sort by week
                  // Your sorting logic here...
                }
              }),*/
              const SizedBox(width: 15),
              const Text(
                "Admin Approval",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
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
                              title: Text(appointment.description),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appointment.appointmenttype),
                                  Text(appointment.date.toDate().toString()),
                                  Text('User ID: ${appointment.userID}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => approveAppointment(appointment),
                                    icon: const Icon(Icons.check),
                                  ),
                                  IconButton(
                                    onPressed: () => declineAppointment(appointment),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ...events.map(
                                (event) => ListTile(
                              title: Text(event.description),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.eventType),
                                  Text(event.date.toDate().toString()),
                                  Text('User ID: ${event.userID}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => approveEvent(event),
                                    icon: const Icon(Icons.check),
                                  ),
                                  IconButton(
                                    onPressed: () => declineEvent(event),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
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

  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(data.details),
            const SizedBox(height: 20),
            const Text(
              'Date:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(data.date),
          ],
        ),
      ),
    );
  }
}