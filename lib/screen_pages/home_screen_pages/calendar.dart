import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2050),
                  calendarFormat: CalendarFormat.month,
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(fontSize: 20),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Events',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Example events, replace with your data
                  EventWidget(date: DateTime.now(), information: 'Event 1 details...'),
                  EventWidget(date: DateTime.now().add(const Duration(days: 2)), information: 'Event 2 details...'),
                  EventWidget(date: DateTime.now().add(const Duration(days: 5)), information: 'Event 3 details...'),
                  // Add more EventWidget as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  final DateTime date;
  final String information;

  const EventWidget({Key? key, required this.date, required this.information}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: ${DateFormat('yyyy-MM-dd').format(date)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Information: $information',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
