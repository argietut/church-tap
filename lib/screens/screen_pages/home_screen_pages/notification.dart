import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final bool hasNotifications;

  const NotificationScreen({Key? key, this.hasNotifications = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Center(
        child: hasNotifications
            ? ListView(
          children: const [
            // Your notification items/widgets here
            ListTile(
              title: Text('Notification 1'),
            ),
            ListTile(
              title: Text('Notification 2'),
            ),
            // Add more notifications as needed
          ],
        )
            : const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'No notifications yet!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Stay tuned for updates.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NotificationScreen(),
  ));
}
