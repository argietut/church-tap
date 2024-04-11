import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';

class Notifications extends StatefulWidget {
  final String userID;

  const Notifications({Key? key, required this.userID}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchPendingAppointments();
  }

  void fetchPendingAppointments() async {
    List<Appointment> pendingAppointments = [];

    Stream<QuerySnapshot> stream =
    UserStorage().fetchPendingAppointments(widget.userID);
    stream.listen((QuerySnapshot snapshot) {
      setState(() {
        pendingAppointments.clear();
        snapshot.docs.forEach((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            pendingAppointments.add(Appointment(
              id: doc.id,
              title: data['title'] ?? '',
              status: data['status'] ?? '',
            ));
          }
        });
        appointments = pendingAppointments;
      });
    });
  }

  Future<void> approveAppointment(String appointmentId) async {
    try {
      await UserStorage().approvedAppointment(widget.userID, appointmentId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error approving appointment')),
      );
      log("Error approving appointment: $e");
    }
  }

  Future<void> denyAppointment(String appointmentId) async {
    try {
      await UserStorage().denyAppointment(widget.userID, appointmentId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error denying appointment')),
      );
      log("Error denying appointment: $e");
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.mark_chat_read
                  ),
                ),
                const Text(
                  "Notification",
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
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        appointments[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: ${appointments[index].status}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          if (appointments[index].status == 'Approved' ||
                              appointments[index].status == 'Denied')
                            Text(
                              appointments[index].notification ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                      trailing: appointments[index].status == 'Pending'
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              approveAppointment(appointments[index].id);
                            },
                            icon: const Icon(Icons.check),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {
                              denyAppointment(appointments[index].id);
                            },
                            icon: const Icon(Icons.close),
                            color: Colors.red,
                          ),
                        ],
                      )
                          : null,
                    ),
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

class Appointment {
  final String id;
  final String title;
  final String status;
  final String? notification;

  Appointment({
    required this.id,
    required this.title,
    required this.status,
    this.notification,
  });
}
