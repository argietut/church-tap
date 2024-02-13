import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
       appBar: AppBar(
         automaticallyImplyLeading: true,

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const Notifications()),
                //     );
                //   },
                //   icon: const Icon(Icons.notifications),
                // ),
                Text(
                  "Appointments",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'No appointments booked yet!',
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Start planning your next chapter in your lift, eyyy!.',
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for the button here
                  // For example: Navigator.push...
                },
                child: const Text(
                  'Create Appointment',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black, // Set text color to black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
