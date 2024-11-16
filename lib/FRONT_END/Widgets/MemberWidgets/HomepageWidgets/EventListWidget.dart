import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/Widgets/MemberWidgets/HomepageWidgets/EventCardWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventListWidget extends StatelessWidget {
  final UserStorage userStorage;
  final String selectedEventType;
  final bool sortByMonth;
  final bool sortByDay;

  const EventListWidget({
    required this.userStorage,
    required this.selectedEventType,
    required this.sortByMonth,
    required this.sortByDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: userStorage.fetchCreateMemberEvent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No church event available yet!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        } else {
          List<DocumentSnapshot> events = snapshot.data!.docs;

          // Filter and sort events
          events = _filterAndSortEvents(events);

          if (events.isEmpty) {
            return const Center(
              child: Text(
                'No events posted yet...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCardWidget(event: events[index]);
              },
            );
          }
        }
      },
    );
  }

  List<DocumentSnapshot> _filterAndSortEvents(List<DocumentSnapshot> events) {
    if (selectedEventType == 'Upcoming') {
      events = events.where((event) {
        DateTime eventDate = (event['date'] as Timestamp).toDate();
        return eventDate.isAfter(DateTime.now());
      }).toList();
    } else if (selectedEventType == 'Ongoing') {
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
        return eventDate.isBefore(DateTime.now().subtract(const Duration(days: 1)));
      }).toList();
    }

    if (sortByMonth) {
      events.sort((a, b) {
        DateTime dateA = (a['date'] as Timestamp).toDate();
        DateTime dateB = (b['date'] as Timestamp).toDate();
        return dateA.month.compareTo(dateB.month);
      });
    } else if (sortByDay) {
      events.sort((a, b) {
        DateTime dateA = (a['date'] as Timestamp).toDate();
        DateTime dateB = (b['date'] as Timestamp).toDate();
        return dateA.day.compareTo(dateB.day);
      });
    }

    return events;
  }
}
