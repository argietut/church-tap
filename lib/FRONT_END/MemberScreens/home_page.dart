import 'dart:ui';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/mapstoragescreen.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/search_button_details.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  final UserStorage userStorage = UserStorage();
  String _selectedEventType = 'Upcoming';
  bool _isSearching = false;
  bool sortByMonth = false;
  bool sortByDay = false;
  int clickCount = 0;

  String formatDateTime(Timestamp? timeStamp) {
    if (timeStamp == null) {
      return " No date available";
    }
    DateTime dateTime = timeStamp.toDate();
    List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";
  }

  bool isEventCompleted(DocumentSnapshot event) {
    Timestamp timeStamp = event["date"];
    DateTime eventDate = timeStamp.toDate();
    return eventDate.isBefore(DateTime.now().subtract(Duration(days: 1)));
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        flexibleSpace: Stack(
          children: [
            Positioned(
              left: 20.0,
              right: 20.0,
              top: 40.0,
              child: Row(
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
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(
                        side: BorderSide(color: appGrey, width: 1),
                      ),
                    ),
                    icon: const Icon(Icons.sort),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapStorageScreen(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: '',
                      child: SearchButton(
                        isSearching: _isSearching,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 20.0,
              right: 20.0,
              top: 110.0,
              child: Divider(
                color: appGreen,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  items: <String>['Upcoming', 'Ongoing', 'Completed']
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
                'Church events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: userStorage.fetchCreateMemberEvent(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No church event available yet!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        } else {
                          List<DocumentSnapshot> events = snapshot.data!.docs;

                          // Filter events based on the selected event type
                          if (_selectedEventType == 'Upcoming') {
                            events = events.where((event) {
                              DateTime eventDate = (event['date'] as Timestamp).toDate();
                              return eventDate.isAfter(DateTime.now());
                            }).toList();
                          } else if (_selectedEventType == 'Ongoing') {
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
                            events = sortEventsByMonth(events);
                          } else if (sortByDay) {
                            events = sortEventsByDay(events);
                          }

                          if (events.isEmpty) {
                            return const Center(
                              child: Text(
                                'No events posted yet...',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                Timestamp timeStamp = event["date"];
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

                                bool completed = isEventCompleted(event); // Check if event is completed
                                Color cardColor = completed ? Colors.grey.shade200 : Colors.green.shade200; // Set color based on completion

                                return Card(
                                  color: cardColor,
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 4,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      'Event: ${event['appointmenttype'] ?? ''}',
                                      style: const TextStyle(),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Description: ${event['description'] ?? ''}'),
                                        Text('Date: $formattedDate'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
