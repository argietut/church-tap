import 'dart:developer';
import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Map<String, bool> showOptionsMap = {};

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
    return eventDate.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  }

  String getCurrentUserId() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid ?? '';
  }

  Future<void> deleteApprovedAppointment(String uid, String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("members")
          .collection(uid)
          .doc("Event")
          .collection("Approved Appointment")
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
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
            const Row(
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
            const SizedBox(height: 15),
            const Divider(
              color: Colors.green,
            ),
            const SizedBox(height: 10),
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
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No history appointment...',
                        style: TextStyle(
                          fontSize: 18,
                          color: appGrey,
                        ),
                      ),
                    );
                  }

                  List<DocumentSnapshot> sortedAppointments = snapshot.data!.docs;


                  return ListView.builder(
                    itemCount: sortedAppointments.length,
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
                        return const SizedBox();
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
                            'Appointment: ${data['appointmenttype'] ?? ''}',
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                onPressed: () {
                                  setState(() {
                                    showOptionsMap[id] =
                                    !(showOptionsMap[id] ?? false);
                                  });
                                },
                              ),
                              if (showOptionsMap[id] ?? false)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 8.0),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red,
                                            size: 24.0
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Confirm Delete"),
                                                content: const Text(
                                                    "Are you sure you want to delete this request?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                        "Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      final uid =
                                                      getCurrentUserId();
                                                      if (uid.isNotEmpty) {
                                                        deleteApprovedAppointment(
                                                            uid,
                                                            document.id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      } else {
                                                        print(
                                                            'User is not logged in.');
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: appRed),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
