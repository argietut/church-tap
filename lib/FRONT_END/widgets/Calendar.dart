import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final String type;
  const CustomCalendar({super.key, required this.type});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  TableCalendar _tableCalendar =
  TableCalendar(
      focusedDay: DateTime.now(),
      currentDay: DateTime.now(),
      firstDay: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day),
      lastDay: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day,0),
      onDaySelected: (selectedDay, focusedDay) => if(foc),
  );

  @override
  Widget build(BuildContext context) {

  if(widget.type == "admin"){
return admin(context);
  }
  else{
return member(context);
  }
  }



  Widget admin(BuildContext context) {

    return Scaffold(
      body: ,);
  }

Widget member(BuildContext context){
  return Scaffold(body: _tableCalendar,);
}
}