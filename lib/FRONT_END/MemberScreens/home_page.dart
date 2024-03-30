import 'dart:ui';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/map_page.dart';
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
  bool _isSearching = false;
  final UserStorage userStorage = UserStorage();
  String _selectedEventType = 'Upcoming Events';
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
        backgroundColor: Colors.white,
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Church event',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  if (_isSearching)
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: const Center(
                        child: MapPage(),
                      ),
                    ),
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
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No church event available yet!',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey
                              ),
                            ),
                          );
                        } else {
                          List<DocumentSnapshot> events = snapshot.data!.docs;
                          if (sortByMonth) {
                            events = sortEventsByMonth(events);
                          } else if (sortByDay) {
                            events = sortEventsByDay(events);
                          }
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
                              return Card(
                                color: Colors.green.shade200,
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 4
                                ),
                                child: ListTile(
                                  title: Text(
                                    'Event type: ${event['appointmenttype'] ?? ''}',
                                    style: const TextStyle(

                                    ),
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
