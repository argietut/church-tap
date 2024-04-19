import 'dart:developer';
import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TapAuth tapAuth = TapAuth();
  late Stream<QuerySnapshot> _approvedAppointmentsStream;

  void initState(){
    super.initState();
    _initializeStream();
  }
  Future<void> _initializeStream() async {
    try {
      final currentUser = tapAuth.getCurrentUser();
      if (currentUser != null) {
        _approvedAppointmentsStream =
            UserStorage().fetchApprovedAppointments(currentUser.uid);
      } else {
        throw ArgumentError("Current user not found.");
      }
    } catch (e) {
      log("Error initializing stream: $e");
    }
  }

  bool isAppointmentCompleted(DateTime eventDate) {
    return eventDate.isBefore(DateTime.now().subtract(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 50),
                Text(
                  "History",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              color: Colors.green,
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _approvedAppointmentsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}')
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No completed appointment.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  List<DocumentSnapshot> sortedAppointments =
                      snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: sortedAppointments.length, // Update itemCount to the length of sortedAppointments
                    itemBuilder: (context, index) {
                      final document = sortedAppointments[index];
                      final id = document.id;
                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      Timestamp timeStamp = data["date"];
                      DateTime dateTime = timeStamp.toDate();
                      List<String> months = [
                        "January",
                        "February",
                        "March",
                        "April",
                        "May",
                        "June",
                        "July",
                        "August",
                        "September",
                        "October",
                        "November",
                        "December"
                      ];
                      String formattedDate =
                          "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";

                      if (!isAppointmentCompleted(dateTime)) {
                        return SizedBox();
                      }

                      return Card(
                        color: Colors.grey.shade200,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4
                        ),
                        child: ListTile(
                          title: Text(
                            'Appointment type: ${data['appointmenttype'] ?? ''}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: ${data['description'] ?? ''}',
                              ),
                              Text(
                                'Date: $formattedDate',
                              ),
                            ],
                          ),
                        ),
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
