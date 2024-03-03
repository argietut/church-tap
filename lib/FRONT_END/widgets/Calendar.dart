import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    _tableCalendar = TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          print("Selected $_selectedDay");
          print("Focused $_focusedDay");
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      calendarStyle: CalendarStyle(
        weekendTextStyle: TextStyle(
            color: Colors.red),
        outsideDaysVisible: false,
          weekNumberTextStyle:TextStyle(
              color: Colors.blue)
          ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          final red = DateFormat.E().format(day);
          final blue = DateFormat.E().format(day);

        if(day.weekday == DateTime.sunday || day.weekday == DateTime.saturday){
          return Center(
            child: Text(
              red,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        else{
          return Center(
            child: Text(
              blue,
              style: TextStyle(color: Colors.blue),
            ),
          );
        }
      },),
    );


  if(widget.type == "admin"){
return admin(context);
  }

  else{
return member(context);
  }

  }

  Widget admin(BuildContext context) {
    return Scaffold(
      body: _tableCalendar,);
  }

Widget member(BuildContext context){
  return Scaffold(body: _tableCalendar,);
}
}