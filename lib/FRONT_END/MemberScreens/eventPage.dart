import 'dart:developer';
import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/event_screen_pages/event_source_directory/edit_event.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/event_screen_pages/history.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _EventPageState extends State<EventPage> {
  final TapAuth tapAuth = TapAuth();
  late Stream<QuerySnapshot> _approvedAppointmentsStream;
  late Stream<QuerySnapshot> _pendingAppointmentsStream;
  Map<String, bool> showOptionsMap = {};
  bool sortByMonth = false;
  bool sortByDay = false;
  int clickCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  Future<void> _initializeStream() async {
    try {
      final currentUser = tapAuth.getCurrentUser();
      if (currentUser != null) {
        _approvedAppointmentsStream =
            UserStorage().fetchApprovedAppointments(currentUser.uid);
        _pendingAppointmentsStream =
            UserStorage().fetchPendingAppointments(currentUser.uid);
      } else {
        throw ArgumentError("Current user not found.");
      }
    } catch (e) {
      log("Error initializing stream: $e");
    }
  }

  Future<void> deletePendingRequest(String uid, String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("members")
          .collection(uid)
          .doc("Event")
          .collection("Pending Appointment")
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  String getCurrentUserId() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser?.uid ?? '';
  }

  List<DocumentSnapshot> sortAppointmentsByMonth(
      QuerySnapshot snapshot) {
    List<DocumentSnapshot> appointments = snapshot.docs;
    if (sortByMonth) {
      appointments.sort((a, b) {
        DateTime dateA =
        (a.data() as Map<String, dynamic>)["date"].toDate();
        DateTime dateB =
        (b.data() as Map<String, dynamic>)["date"].toDate();
        return dateA.month.compareTo(dateB.month);
      });
    }
    return appointments;
  }


  List<DocumentSnapshot> sortAppointmentsByDay(
      List<DocumentSnapshot> appointments) {
    appointments.sort((a, b) {
      DateTime dateA =
      (a.data() as Map<String, dynamic>)["date"].toDate();
      DateTime dateB =
      (b.data() as Map<String, dynamic>)["date"].toDate();
      return dateA.day.compareTo(dateB.day);
    });
    return appointments;
  }

  // Check if appointment is completed (occurred before current date)
  bool isAppointmentCompleted(DateTime eventDate) {
    return eventDate.isBefore(DateTime.now().subtract(Duration(days: 1)));
  }
  @override
  Widget build(BuildContext context) {
    if (_pendingAppointmentsStream == null ||
        _approvedAppointmentsStream == null) {
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
                    setState(() {
                      clickCount++;
                      if (clickCount % 2 == 1) {
                        sortByMonth = true;
                        sortByDay = false;
                      } else {
                        sortByMonth = false;
                        sortByDay = true;
                      }
                    });
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
                IconButton(
                  onPressed: () {
                   Navigator.push(context,
                     MaterialPageRoute(
                         builder: (context) =>
                         const HistoryPage()
                     ),
                   );
                  },
                  icon: const Icon(Icons.history),
                ),


              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.green,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Approved requests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
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
                              'No approved appointment.',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        }
                        List<DocumentSnapshot> sortedAppointments =
                            snapshot.data!.docs;
                        if (sortByMonth) {
                          sortedAppointments =
                              sortAppointmentsByMonth(snapshot.data!);
                        } else if (sortByDay) {
                          sortedAppointments =
                              sortAppointmentsByDay(snapshot.data!.docs);
                        }
                        sortedAppointments = sortedAppointments
                            .where((document) =>
                        !isAppointmentCompleted((document
                            .data() as Map<String, dynamic>)["date"].toDate()))
                            .toList();

                        return ListView.builder(
                          itemCount: sortedAppointments.length,
                          itemBuilder: (context, index) {
                            final document =
                            sortedAppointments[index];
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
                            return Card(
                              color: Colors.green.shade200,
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: ListTile(
                                title: Text(
                                  'Appointment: ${data['appointmenttype'] ?? ''}',
                                ),
                                subtitle: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _pendingAppointmentsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No pending appointment.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  List<DocumentSnapshot> sortedAppointments =
                      snapshot.data!.docs;
                  if (sortByMonth) {
                    sortedAppointments =
                        sortAppointmentsByMonth(snapshot.data!);
                  } else if (sortByDay) {
                    sortedAppointments =
                        sortAppointmentsByDay(snapshot.data!.docs);
                  }
                  return ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Pending requests',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ...sortedAppointments.map((
                          DocumentSnapshot document,
                          ) {
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
                        return Card(
                          color: Colors.amber.shade200,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                  icon: const Icon(Icons.info_outline),
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
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: appGreen, size: 24.0),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditEvent(
                                                      documentId: document.id,
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.now(),
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8.0),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red, size: 24.0),
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
                                                          deletePendingRequest(
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
                      }).toList(),
                    ],
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