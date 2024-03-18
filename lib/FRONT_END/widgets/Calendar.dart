import 'package:bethel_app_final/FRONT_END/widgets/add_events.dart';
import 'package:flutter/cupertino.dart';
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
  int currentYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    OutlinedButton(onPressed: () {

    }, child: const Text("Hello World"));
    _tableCalendar = TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(currentYear, 1, 1),
      lastDay: DateTime.utc(currentYear + 10, 1, 1),
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
      body: ListView(children: [_tableCalendar],)
      ,);
  }

Widget member(BuildContext context){
  return Scaffold(
    body: ListView(children: [Row(children: [AppointmentMakerButton(),EventMakerButton()],mainAxisAlignment: MainAxisAlignment.end,),_tableCalendar],)
    ,);
}
Widget AppointmentMakerButton(){
    return TextButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),));
    }, child: Row(children: [Icon(Icons.calendar_today),Text("  Appointment")],
      mainAxisAlignment: MainAxisAlignment.center,),
    );
}
Widget EventMakerButton(){
    return TextButton(onPressed: () {
      
    }, child: Row(children: [Icon(Icons.calendar_month),Text("  Events")],mainAxisAlignment: MainAxisAlignment.center,));
}
}