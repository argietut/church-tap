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
  String _selectedEventType = 'Upcoming Events';
  bool sortByMonth = false;
  bool sortByDay = false;
  int clickCount = 0;

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

  List<DocumentSnapshot> sortEventsByMonth(List<DocumentSnapshot> events) {
    events.sort((a, b) {
      DateTime dateA = (a.data() as Map<String, dynamic>)["date"].toDate();
      DateTime dateB = (b.data() as Map<String, dynamic>)["date"].toDate();
      return dateA.month.compareTo(dateB.month);
    });
    return events;
  }

  List<DocumentSnapshot> sortEventsByDay(List<DocumentSnapshot> events) {
    events.sort((a, b) {
      DateTime dateA = (a.data() as Map<String, dynamic>)["date"].toDate();
      DateTime dateB = (b.data() as Map<String, dynamic>)["date"].toDate();
      return dateA.day.compareTo(dateB.day);
    });
    return events;
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
            const SizedBox(height: 10),
            DropdownButtonHideUnderline(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: DropdownButton<String>(
                  value: _selectedEventType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEventType = newValue!;
                    });
                  },
                  items: <String>['Upcoming Events', 'Completed Events']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: userStorage.fetchAllApprovedAppointments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No ${_selectedEventType.toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  List<DocumentSnapshot> sortedEvents = snapshot.data!.docs;
                  if (sortByMonth) {
                    sortedEvents = sortEventsByMonth(sortedEvents);
                  } else if (sortByDay) {
                    sortedEvents = sortEventsByDay(sortedEvents);
                  }
                  return ListView.builder(
                    itemCount: sortedEvents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = sortedEvents[index];
                      final id = document.id;
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      Timestamp timeStamp = data["date"];
                      String formattedDate = formatDateTime(timeStamp);

                      if (_selectedEventType == 'Completed Events') {
                        if (DateTime.now().isBefore(timeStamp.toDate())) {
                          return const SizedBox.shrink();
                        }
                      } else {
                        if (DateTime.now().isAfter(timeStamp.toDate())) {
                          return const SizedBox.shrink();
                        }
                      }

                      return Card(
                        color: _selectedEventType == 'Completed Events'
                            ? Colors.grey
                            : appGreen3,
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
