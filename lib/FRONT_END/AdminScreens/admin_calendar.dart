import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AdminCalendar extends StatefulWidget {
  const AdminCalendar({Key? key}) : super(key: key);

  @override
  State<AdminCalendar> createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  bool hasEvents = false; // Assume no events initially

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
                    onPressed: () {

                    },
                    style: IconButton.styleFrom(
                    ),
                    icon: const Icon(Icons.tune),
                  ),
                  const Text(
                    "Admin Calendar",
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
              Column(
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
                            color: appBlue,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: appGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
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
