import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  late Stream<QuerySnapshot> _notificationStream;
  Map<String, bool> showOptionsMap = {};
  Set<String> clickedNotificationIds = {};
  int _notificationCount = 0;

  @override
  void initState() {
    _notificationStream = UserStorage()
        .getNotification(TapAuth()
        .auth.currentUser!
        .uid);
    super.initState();
  }

  Future<void> deleteNotifications(String uid, String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("members")
          .collection(uid)
          .doc("Event")
          .collection("Notification")
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

  void _updateNotificationCount({bool decrement = false}) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      if (decrement) {
        setState(() {
          _notificationStream = UserStorage().getNotification(uid);
          _notificationCount--;
          if (_notificationCount < 0) {
            _notificationCount = 0;
          }
        });
      }
    }
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
                  onPressed: () {},
                  icon: const Icon(Icons.mark_chat_read_outlined),
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
              color: Colors.green,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: _notificationStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.green.shade200,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No notifications...',
                              style: TextStyle(
                                fontSize: 18,
                                color: appGrey,
                              ),
                            ),
                          );
                        }
                        List<DocumentSnapshot> notifications = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final document = notifications[index];
                            final id = document.id;
                            Map<String, dynamic> notif = document.data() as Map<String, dynamic>;
                            Timestamp timeStamp = notif["date"];
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
                            bool isBold = clickedNotificationIds.contains(id);
                            return GestureDetector(
                              onTap: isBold
                                  ? null // Disable GestureDetector if notification is already clicked
                                  : () {
                                setState(() {
                                  clickedNotificationIds.add(id);
                                  // Decrement notification count
                                  _updateNotificationCount(decrement: true);
                                });
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Your ${notif['appointmenttype']}',
                                              style: TextStyle(
                                                fontWeight: isBold ? FontWeight.normal : FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Text(" at "),
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontWeight: isBold ? FontWeight.normal : FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Status: "),
                                          Text(
                                            notif['status'],
                                            style: TextStyle(
                                              fontWeight: isBold ? FontWeight.normal : FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text('Description: ${notif['description'] ?? ''}')
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.more_vert_outlined),
                                        onPressed: () {
                                          setState(() {
                                            showOptionsMap[id] = !(showOptionsMap[id] ?? false);
                                          });
                                        },
                                      ),
                                      if (showOptionsMap[id] ?? false)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(width: 8.0),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red, size: 24.0),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text("Confirm Delete"),
                                                        content: const Text("Are you sure you want to delete this request?"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text("Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              final uid = getCurrentUserId();
                                                              if (uid.isNotEmpty) {
                                                                deleteNotifications(uid, document.id);
                                                                Navigator.of(context).pop();
                                                              } else {
                                                                print('User is not logged in.');
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(color: appRed),
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
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
