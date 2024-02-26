import 'package:flutter/material.dart';

class AdminEvents extends StatefulWidget {
  const AdminEvents({Key? key}) : super(key: key);

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  bool hasEvents = false; // Assume no events initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search icon tap
            },
          ),
        ],
      ),
      body: Center(
        child: hasEvents
            ? /* Widget for displaying events when available */
        const Text("Events will be listed here.")
            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No events posted yet.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "Stay tuned for upcoming events!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
