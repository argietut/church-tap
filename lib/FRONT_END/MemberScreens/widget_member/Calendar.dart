import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/appointment_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/appointment_source_directory/add_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late TableCalendar _tableCalendar;//
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  int currentYear = DateTime.now().year;
  UserStorage storage = UserStorage();
  TapAuth tapAuth = TapAuth();

/*  @override
  void initState() {
    storage.getPendingDate(tapAuth.auth.currentUser!.uid);
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    _tableCalendar = TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(currentYear, 1, 1),
      lastDay: DateTime.utc(currentYear + 1, 1, 1),
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
      enabledDayPredicate: (day) {
        List<dynamic> arr = [1,2,3,4,5];
        Future<List> a = storage.getPendingDate(tapAuth.auth.currentUser!.uid);
        a.then((value) {
          print(value.length);
        },);

//WORKING BUT FUCKING PRINTS FUCKTILLION TIMES
       /* Future<List> a = storage.getPendingDate(tapAuth.auth.currentUser!.uid);
        a.then((value) {
          for(int i = 0;i < value.length;i++){
            print("${value[i]} $i ");
          }
        },);*/
      //  fillList();
        if(widget.type == "member") {
          for(int i = 0;i < arr.length;i++){
            if(day.day == arr[i]){
              return false;
            }
          }
        }
        else{
          if(day.day == 6){
            return false;
          }
          else{
            return true;
          }
        }
  return true;
      },
      calendarBuilders: CalendarBuilders(
        disabledBuilder: (context, day, focusedDay) {
          return  Container(
            decoration: BoxDecoration(color: Colors.black26),
            child: Center(
              child: Text(
                "${day.day}",
                style: TextStyle(
                    color: Colors.black),
              ),
            ),
          );
        },
        defaultBuilder:(context, day, focusedDay) {
          if(day.weekday == DateTime.sunday || day.weekday == DateTime.saturday){
            return  Container(
              decoration: BoxDecoration(color: Colors.green.shade300),
              child: Center(
                child: Text(
                  "${day.day}",
                  style: TextStyle(
                      color: Colors.black),
                ),
              ),
            );
          }
        },
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
    appBar: AppBar(
      automaticallyImplyLeading: true),
    body: ListView(children: [_tableCalendar,Row(children: [AppointmentMakerButton(),EventMakerButton()],mainAxisAlignment: MainAxisAlignment.center)],)
    ,);
}
Widget AppointmentMakerButton(){
    return TextButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddAppointment(firstDate: DateTime.utc(currentYear,1,1), lastDate: DateTime(currentYear+1,1,1,0), selectedDate:_selectedDay ),));
    }, child: Row(children: [Icon(Icons.calendar_today),Text("  Appointment")],
      mainAxisAlignment: MainAxisAlignment.center,),
    );
}
Widget EventMakerButton(){
    return TextButton(onPressed: () {
      
    }, child: Row(children: [Icon(Icons.calendar_month),Text("  Events")],mainAxisAlignment: MainAxisAlignment.center,));
}
/*void fillList() async {
    setState(() async{
      arr = await storage.getPendingDate(tapAuth.auth.currentUser!.uid);
    });

}*/
}