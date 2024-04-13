import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final UserStorage userStorage = UserStorage();
  late Stream<QuerySnapshot> _approvedAppointmentsStream;
  late Stream<QuerySnapshot> _churchEventsStream;
  String _selectedEventType = 'Upcoming Events';
  bool sortByMonth = false;
  bool sortByDay = false;
  int clickCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeStreams();
  }

  Future<void> _initializeStreams() async {
    try {
      _approvedAppointmentsStream = userStorage.fetchAllApprovedAppointments();
      _churchEventsStream = userStorage.fetchCreateMemberEvent();
    } catch (e) {
      print('Error initializing streams: $e');
    }
  }

  String formatDateTime(Timestamp? timeStamp) {
    if (timeStamp == null) {
      return 'No date available';
    }
    DateTime dateTime = timeStamp.toDate();
    List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";
  }

  List<DocumentSnapshot> _sortEventsByMonth(List<DocumentSnapshot> events) {
    events.sort((a, b) {
      DateTime dateA = (a.data() as Map<String, dynamic>)["date"].toDate();
      DateTime dateB = (b.data() as Map<String, dynamic>)["date"].toDate();
      return dateA.month.compareTo(dateB.month);
    });
    return events;
  }

  List<DocumentSnapshot> _sortEventsByDay(List<DocumentSnapshot> events) {
    events.sort((a, b) {
      DateTime dateA = (a.data() as Map<String, dynamic>)["date"].toDate();
      DateTime dateB = (b.data() as Map<String, dynamic>)["date"].toDate();
      return dateA.day.compareTo(dateB.day);
    });
    return events;
  }

  bool isEventCompleted(DocumentSnapshot event) {
    Timestamp timeStamp = event["date"];
    DateTime eventDate = timeStamp.toDate();
    return eventDate.isBefore(DateTime.now().subtract(Duration(days: 1)));
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
                  "Admin Events",
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
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedEventType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEventType = newValue!;
                    });
                  },
                  items: <String>['Upcoming Events', 'Ongoing Events', 'Completed Events']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: appBlack,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Members approved appointments',
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No ${_selectedEventType.toLowerCase()} yet...',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  List<DocumentSnapshot> events = snapshot.data!.docs;
                  if (_selectedEventType == 'Upcoming Events') {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      return eventDate.isAfter(DateTime.now());
                    }).toList();
                  } else if (_selectedEventType == 'Ongoing Events') {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      DateTime currentDate = DateTime.now();
                      return eventDate.year == currentDate.year &&
                          eventDate.month == currentDate.month &&
                          eventDate.day == currentDate.day;
                    }).toList();
                  } else {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      return isEventCompleted(event);
                    }).toList();
                  }

                  if (sortByMonth) {
                    events = _sortEventsByMonth(events);
                  } else if (sortByDay) {
                    events = _sortEventsByDay(events);
                  }
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return _buildApprovedAppointmentCard(events[index]);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Church events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _churchEventsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No ${_selectedEventType.toLowerCase()} yet...',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  List<DocumentSnapshot> events = snapshot.data!.docs;
                  if (_selectedEventType == 'Upcoming Events') {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      return eventDate.isAfter(DateTime.now());
                    }).toList();
                  } else if (_selectedEventType == 'Ongoing Events') {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      DateTime currentDate = DateTime.now();
                      return eventDate.year == currentDate.year &&
                          eventDate.month == currentDate.month &&
                          eventDate.day == currentDate.day;
                    }).toList();
                  } else {
                    events = events.where((event) {
                      DateTime eventDate = (event['date'] as Timestamp).toDate();
                      return isEventCompleted(event);
                    }).toList();
                  }

                  if (sortByMonth) {
                    events = _sortEventsByMonth(events);
                  } else if (sortByDay) {
                    events = _sortEventsByDay(events);
                  }
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return _buildChurchEventCard(events[index]);
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

  Widget _buildApprovedAppointmentCard(DocumentSnapshot event) {
    Map<String, dynamic> data = event.data() as Map<String, dynamic>;
    Timestamp timeStamp = data["date"];
    String formattedDate = formatDateTime(timeStamp);
    return Card(
      color: Colors.green.shade200,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
            Text(
              'Name: ${data['name'] ?? ''}',
            ),
            Text(
              'Email: ${data['email'] ?? ''}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChurchEventCard(DocumentSnapshot event) {
    Map<String, dynamic> data = event.data() as Map<String, dynamic>;
    Timestamp timeStamp = data["date"];
    String formattedDate = formatDateTime(timeStamp);
    return Card(
      color: Colors.green.shade200,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        title: Text(
          'Event type: ${data['eventType'] ?? ''}',
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
  }
}
