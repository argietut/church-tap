import 'dart:async';
import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/appointment_source_directory/add_appointment.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final String type;
  const CustomCalendar({super.key, required this.type});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late TableCalendar _tableCalendar;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  int currentYear = DateTime.now().year;
  UserStorage storage = UserStorage();
  TapAuth tapAuth = TapAuth();
  late Future _pendingDate;
  late Future _disabledDate;
  late Future _approvedDate;
  List<DateTime> disabledDays = [];
  List<DateTime> pendingDays = [];
  List<DateTime> approvedDate = [];

  @override
  void initState() {
    _pendingDate = storage.getPendingDate(tapAuth.auth.currentUser!.uid);
    _disabledDate = storage.getDisableDay();
    _approvedDate = storage.getApprovedDate(tapAuth.auth.currentUser!.uid, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tableCalendar = TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDay: DateTime.utc(DateTime.now().year + 1, 2, 1),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      calendarStyle: const CalendarStyle(
          weekendTextStyle: TextStyle(color: Colors.red),
          outsideDaysVisible: false,
          weekNumberTextStyle: TextStyle(color: Colors.blue)),
      onDayLongPressed: (selectedDay, focusedDay) {
        if (widget.type == "admins") {
          var setDisableDays = <String, dynamic>{
            "date": Timestamp.fromDate(_selectedDay),
            "userID": tapAuth.getCurrentUserUID(),
            "name": tapAuth.auth.currentUser!.displayName
          };
          storage.setDisableDay(setDisableDays, tapAuth.auth.currentUser!.uid);
        }
      },
      onDisabledDayLongPressed: (day) {
        if (widget.type == "admins") {
          for (var disableDay in disabledDays) {
            if (day.month == disableDay.month &&
                day.day == disableDay.day &&
                day.year == disableDay.year) {
              storage.unsetDisableDay(day.day, day.month, day.year);
              break; // Stops the loop for no more unecesarry checks
            }
          }
        }
      },
      onCalendarCreated: (pageController) {},
      enabledDayPredicate: (day) {
        for (int i = 0; i < disabledDays.length; i++) {
          if (disabledDays[i].month == day.month &&
              disabledDays[i].day == day.day &&
              disabledDays[i].year == day.year) {
            return false;
          }
        }
        return true;
      },
      calendarBuilders: CalendarBuilders(
        disabledBuilder: (context, day, focusedDay) {
          return Container(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Center(
              child: Text(
                "${day.day}",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
            for (int i = 0; i < pendingDays.length; i++) {
              if (pendingDays[i].month == day.month &&
                  pendingDays[i].day == day.day &&
                  pendingDays[i].year == day.year) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      border: Border.all(
                          color: Colors.black26,
                          strokeAlign: BorderSide.strokeAlignInside)),
                  child: Center(
                    child: Text(
                      "${day.day}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }
            }
            for(int i = 0;i < approvedDate.length;i++){
              if(approvedDate[i].month == day.month &&
                  approvedDate[i].day == day.day &&
                  approvedDate[i].year == day.year) {
               return Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen.shade200,
                      border: Border.all(
                          color: Colors.black26,
                          strokeAlign: BorderSide.strokeAlignInside)),
                  child: Center(
                    child: Text(
                      "${day.day}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }
            }
        },

        dowBuilder: (context, day) {
          final red = DateFormat.E().format(day);
          final blue = DateFormat.E().format(day);
          if (day.weekday == DateTime.sunday ||
              day.weekday == DateTime.saturday) {
            return Center(
              child: Text(
                red,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                blue,
                style: const TextStyle(color: Colors.blue),
              ),
            );
          }
        },
      ),
    );
    return Scaffold(
        body: FutureBuilder(
      future: Future.wait([_pendingDate, _disabledDate,_approvedDate]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && widget.type == "members") {
          disabledDays = snapshot.data![1];
          pendingDays = snapshot.data![0];
          approvedDate = snapshot.data![2];
          return member(context);
        }
        else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && widget.type == "admins") {
          disabledDays = snapshot.data![1];
          approvedDate = snapshot.data![2];
          return admin(context);
        }
        else {
          return
            Center(
            child: CircularProgressIndicator(
              color: Colors.green.shade200,
            ),
          );
        }
      },
    ));
  }

  Widget admin(BuildContext context) {
    return Scaffold(
        body: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 50),
                    Text(
                      "Calendar",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: appGreen,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [_tableCalendar],

                  ),
                ),
                const SizedBox(height: 10),

                const Center(
                  child: Text('Create events',
                  style: TextStyle(
                    fontSize: 18,

                  ),
                  ),
                ),
                const SizedBox(height: 6),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: appGreen), // Adding border
                  ),
                  child: EventMakerButton(context),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
  }

  Widget member(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Request Appointment",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                color: appGreen,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    _tableCalendar,
                    const SizedBox(height: 10),
                    const Center(
                      child: Text('Request appointment',
                        style: TextStyle(
                          fontSize: 18,

                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: appGreen),
                        ),
                        child: AppointmentMakerButton(),
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      );
}
Widget AppointmentMakerButton(){
    return TextButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => AddAppointment(
            firstDate: DateTime.utc(currentYear,1,1),
            lastDate: DateTime(currentYear+1,1,1,0),
            selectedDate:_selectedDay, type: 'members' ),
      )
      );
    }, child: const Row(
      children: [
        Icon(
          Icons.calendar_month
        ),
        Text("  Appointment",
          style: TextStyle(
              color: appBlack
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
     ),
    );
  }

  Widget EventMakerButton(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final DateTime firstDate = DateTime(currentDate.year - 1);
    final DateTime lastDate = DateTime(currentDate.year + 1);
    final DateTime selectedDate = currentDate;

    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddAppointment(
              firstDate: DateTime.utc(currentYear, 1, 1),
              lastDate: DateTime(currentYear + 1, 1, 1, 0),
              selectedDate: _selectedDay,
              type: 'admins', // Provide a church event value
            ),
          ),
        );
      },
      child: const Row(
        children: [
          Icon(Icons.calendar_month_outlined),
          Text(
            "  Events",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}//