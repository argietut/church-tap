import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constant/color.dart';

class AdminCalendar extends StatefulWidget {
  const AdminCalendar({Key? key}) : super(key: key);

  @override
  State<AdminCalendar> createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  List<Appointment> _appointments = [];
  List<Event> _events = [];

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> fetchData(DateTime selectedDay) async {
    final appointmentSnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(selectedDay.year, selectedDay.month, selectedDay.day)))
        .where('date', isLessThan: Timestamp.fromDate(DateTime(selectedDay.year, selectedDay.month, selectedDay.day + 1)))
        .get();

    final eventSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(selectedDay.year, selectedDay.month, selectedDay.day)))
        .where('date', isLessThan: Timestamp.fromDate(DateTime(selectedDay.year, selectedDay.month, selectedDay.day + 1)))
        .get();

    _appointments = appointmentSnapshot.docs.map((doc) => Appointment(
      id: doc.id,
      details: doc['description'] ?? '',
      date: doc['date'] != null ? (doc['date'] as Timestamp).toDate() : null,
    )).toList();

    _events = eventSnapshot.docs.map((doc) => Event(
      id: doc.id,
      details: doc['description'] ?? '',
      date: doc['date'] != null ? (doc['date'] as Timestamp).toDate() : null,
      type: '',
      title: null,
    )).toList();

    setState(() {});
  }

  Future<void> approveAppointment(Appointment appointment) async {
    final approvedAppointmentsCollection =
    FirebaseFirestore.instance.collection('approved_appointments');
    final appointmentData = {
      'title': appointment.details,
      'date': Timestamp.fromDate(appointment.date!),
    };

    try {
      await approvedAppointmentsCollection.add(appointmentData);
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointment.id)
          .delete();
      print('Approved appointment added successfully');
    } catch (e) {
      print('Error adding approved appointment: $e');
    }
  }

  Future<void> approveEvent(Event event) async {
    final approvedEventsCollection =
    FirebaseFirestore.instance.collection('approved_events');
    final eventData = {
      'title': event.details,
      'date': Timestamp.fromDate(event.date!),
    };

    try {
      await approvedEventsCollection.add(eventData);
      await FirebaseFirestore.instance
          .collection('events')
          .doc(event.id)
          .delete();
      print('Approved event added successfully');
    } catch (e) {
      print('Error adding approved event: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchData(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TableCalendar(
                            focusedDay: _focusedDay ?? DateTime.now(),
                            firstDay: DateTime(2000),
                            lastDay: DateTime(2050),
                            calendarFormat: CalendarFormat.month,
                            headerStyle: const HeaderStyle(
                              titleTextStyle: TextStyle(fontSize: 20),
                              formatButtonVisible: false,
                            ),
                            calendarStyle: const CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: appBlue,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Colors.purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onDaySelected: (date, events) {
                              setState(() {
                                _selectedDay = date;
                                _focusedDay = date;
                              });
                              fetchData(date);
                            },
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Events on ${_selectedDay?.toString().split(' ')[0] ?? 'No date selected'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...(_appointments.map((appointment) => ListTile(
                                  title: Text('APPOINTMENT: ${appointment.details}'),
                                  trailing: IconButton(
                                    onPressed: () => approveAppointment(appointment),
                                    icon: const Icon(Icons.check),
                                  ),
                                )).toList()),
                                ...(_events.map((event) => ListTile(
                                  title: Text('EVENT: ${event.details}'),
                                  trailing: IconButton(
                                    onPressed: () => approveEvent(event),
                                    icon: const Icon(Icons.check),
                                  ),
                                )).toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class Appointment {
  final String id;
  final String details;
  final DateTime? date;

  Appointment({required this.id, required this.details, required this.date});
}

class Event {
  final String id;
  final String details;
  final DateTime? date;
  final String type;
  final String? title;

  Event({
    required this.id,
    required this.details,
    required this.date,
    required this.type,
    required this.title,
  });
}