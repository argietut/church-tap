import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  late Stream<QuerySnapshot> _notificationStream;

  @override
  void initState() {
    _notificationStream = UserStorage().getNotification(TapAuth().auth.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {},
                  icon: const Icon(Icons.sort)
              ),
              const Text("Notifications",
              style:TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
            const Divider(
              color: Colors.green,
            ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: _notificationStream,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator(
                            color: Colors.green.shade200,);
                        }
                        else if(snapshot.hasError){
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No Notifications.',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          );
                        }
                        List<DocumentSnapshot> notifications =
                            snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final document =
                            notifications[index];
                            final id = document.id;
                            Map<String, dynamic> notif =
                            document.data() as Map<String, dynamic>;
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
                          return Card(
                            elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                            child: ListTile(
                              //Should Wrap in Inkwel to support bold to unbold text but no time and fucking lazy to do it
                              title: Row(children: [
                                Text("Your "),
                                Text('${notif['appointmenttype']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                Text(" at "),
                                Text(formattedDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),

                              ],
                              ),
                           subtitle: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(children: [Text("Status: "),
                                 Text(notif['status'],
                                 style: TextStyle(
                                     fontWeight: FontWeight.bold),)
                               ],
                               ),
                               Text('Description: ${notif['description'] ?? ''}')
                             ],
                           ), ),
                          );
                        },
                        );
                      },
                  )
              )
            ],
            )
        )
          ],
        ),
      ),
    );
  }
}
