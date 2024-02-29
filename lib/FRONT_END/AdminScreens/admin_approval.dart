import 'package:flutter/material.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  bool hasEvents = false; // Assume no events initially

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
                  style: IconButton.styleFrom(
                    // shape: const CircleBorder(
                    //   side: BorderSide(
                    //     color: appBlack,
                    //     width: 1.0,
                    //   ),
                    // ),
                  ),
                  icon: const Icon(Icons.tune),
                ),
                const Text(
                  "Admin Approval",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'No appointment requests yet!',
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Time to chill and find your self yet.',
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
