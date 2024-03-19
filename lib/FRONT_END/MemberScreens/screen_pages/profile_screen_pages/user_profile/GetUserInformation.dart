import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserInformation extends StatelessWidget {
  final String uniqueID;

  const GetUserInformation({Key? key, required this.uniqueID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc("members")
          .collection(uniqueID)
          .doc("About User")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('User not found');
        }

        Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

        if (data == null) {
          return const Text('User data is null');
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${data["name"]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some space between the Text widgets
                Text(
                  'Email: ${data["email"]}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                // Add more fields as needed
              ],
            ),
          ),
        );

      },
    );
  }
}