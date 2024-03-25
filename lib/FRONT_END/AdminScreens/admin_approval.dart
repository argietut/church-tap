import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  final UserStorage userStorage = UserStorage();
  final StreamController<List<Map<String, dynamic>>> _pendingAppointmentsController =
  StreamController<List<Map<String, dynamic>>>();

  @override
  void initState() {
    super.initState();
    _initializePendingAppointments();
  }

  @override
  void dispose() {
    _pendingAppointmentsController.close();
    super.dispose();
  }

  Future<void> _initializePendingAppointments() async {
    try {
      final List<String> memberIds = await _fetchMemberIds();
      List<Map<String, dynamic>> allPendingAppointments = [];

      for (String memberId in memberIds) {
        final memberPendingAppointments = await userStorage.getAllPendingAppointmentsForMember(memberId);
        allPendingAppointments.addAll(memberPendingAppointments);
      }

      _pendingAppointmentsController.sink.add(allPendingAppointments);
    } catch (e) {
      log("Error initializing pending appointments: $e");
    }
  }

  Future<List<String>> _fetchMemberIds() async {

    return ['member1', 'member2', 'member3'];
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
                  icon: const Icon(Icons.tune),

                ),
                const Text(
                  "Admin approval",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(color: Colors.green),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _pendingAppointmentsController.stream,
                builder: (context, appointmentSnapshot) {
                  if (appointmentSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (appointmentSnapshot.hasError) {
                    return Center(child: Text('Error: ${appointmentSnapshot.error}'));
                  }
                  final allPendingAppointments = appointmentSnapshot.data ?? [];
                  if (allPendingAppointments.isEmpty) {
                    return const Center(child: Text('No pending appointments found.'));
                  }

                  return ListView.builder(
                    itemCount: allPendingAppointments.length,
                    itemBuilder: (context, index) {
                      final appointmentData = allPendingAppointments[index];
                      final documentId = appointmentData['id'];
                      return Card(
                        color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Member ID: ${appointmentData['memberId']}'),
                            ListTile(
                              title: Text('Appointment Type: ${appointmentData['appointmentType']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description: ${appointmentData['description']}'),
                                  Text('Date: ${appointmentData['date']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info),
                                    onPressed: () {
                                      setState(() {
                                        // Handle showing details
                                      });
                                    },
                                  ),
                                  // Add approval and rejection buttons here
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

