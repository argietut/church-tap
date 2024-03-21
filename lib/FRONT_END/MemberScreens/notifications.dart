import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune),
                  ),
                  const Text(
                    "Notifications",
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
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement your logic for marking all as read here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 4),
                    foregroundColor: Colors.blue, // Change color as needed
                  ),
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: appBlack
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // New Notification Text
              const Text(
                "New",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appBlack,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Notification 1"),
                subtitle: Text("Notification description"),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Notification 2"),
                subtitle: Text("Notification description"),
              ),
              
              const SizedBox(height: 20),
              
              // Earlier Notification Text
              const Text(
                "Earlier",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appBlack,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Notification 3"),
                subtitle: Text("Notification description"),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Notification 4"),
                subtitle: Text("Notification description"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
