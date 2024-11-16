import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/mapstoragescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final DocumentSnapshot event;

  const EventCardWidget({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp timeStamp = event['date'];
    DateTime dateTime = timeStamp.toDate();
    List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    String formattedDate =
        "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}";
    bool completed = dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)));
    Color cardColor = completed ? Colors.grey.shade200 : Colors.green.shade200;

    return Card(
      color: cardColor,
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Text(
            event['event_type'][0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(event['event_title']),
        subtitle: Text('Date: $formattedDate'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapStorageScreen(key: key),
            ),
          );
        },
      ),
    );
  }
}
