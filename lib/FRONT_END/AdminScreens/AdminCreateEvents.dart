// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import 'church_event_source/add_event_church.dart';
// import 'church_event_source/church_event_source.dart';
// import 'church_event_source/edit_church_event.dart';
//
// class AdminAppointmentPage extends StatefulWidget {
//   const AdminAppointmentPage({Key? key}) : super(key: key);
//
//   @override
//   State<AdminAppointmentPage> createState() => _AdminAppointmentPageState();
// }
//
// class _AdminAppointmentPageState extends State<AdminAppointmentPage> {
//   late DateTime _focusedDay3;
//   late DateTime _firstDay3;
//   late DateTime _lastDay3;
//   late DateTime _selectedDay3;
//   late CalendarFormat _calendarFormat3;
//   late Map<DateTime, List<ChurchEvent>> _churchEvents;
//
//   @override
//   void initState() {
//     super.initState();
//     _churchEvents = {};
//     _focusedDay3 = DateTime.now();
//     _firstDay3 = DateTime.now().subtract(const Duration(days: 1000));
//     _lastDay3 = DateTime.now().add(const Duration(days: 1000));
//     _selectedDay3 = DateTime.now();
//     _calendarFormat3 = CalendarFormat.month;
//     _loadFirestorechurchEvent(_selectedDay3);
//   }
//
//   _loadFirestorechurchEvent(DateTime selectedDay) async {
//     final selectedDayStart = DateTime(
//       selectedDay.year,
//       selectedDay.month,
//       selectedDay.day,
//       0,
//       0,
//       0,
//     );
//     final selectedDayEnd = DateTime(
//       selectedDay.year,
//       selectedDay.month,
//       selectedDay.day,
//       23,
//       59,
//       59,
//     );
//
//     final churcheventsSnap = await FirebaseFirestore.instance
//         .collection('churchEvents')
//         .where('date', isGreaterThanOrEqualTo: selectedDayStart)
//         .where('date', isLessThanOrEqualTo: selectedDayEnd)
//         .get();
//
//     _churchEvents = _mapSnapshotsToChurchEvents(churcheventsSnap);
//
//     setState(() {});
//   }
//
//   Map<DateTime, List<ChurchEvent>> _mapSnapshotsToChurchEvents(
//       QuerySnapshot snapshot) {
//     final Map<DateTime, List<ChurchEvent>> churchEvents = {};
//
//     for (var doc in snapshot.docs) {
//       final churchEvent =
//       ChurchEvent.fromFirestore(doc.data() as DocumentSnapshot<Object?>, doc.id);
//
//       final day = DateTime.utc(
//         churchEvent.date.year,
//         churchEvent.date.month,
//         churchEvent.date.day,
//       );
//
//       churchEvents.putIfAbsent(day, () => []);
//       churchEvents[day]!.add(churchEvent);
//     }
//
//     return churchEvents;
//   }
//
//   List<ChurchEvent> _getChurchEventsForTheDay(DateTime day) {
//     return _churchEvents[day] ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Church Events',
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           Center( // Wrap the TextButton with Center widget
//             child: TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => AddEventChurch(
//                       churchEvent: _churchEvents,
//                       firstDate3: _firstDay3,
//                       lastDate3: _lastDay3,
//                       selectedDate3: _selectedDay3,
//                     ),
//                   ),
//                 ).then((value) {
//                   if (value == true) {
//                     _loadFirestorechurchEvent(_selectedDay3);
//                   }
//                 });
//               },
//               child: Text(
//                 'Church Event',
//                 style: TextStyle(
//                   color: Theme.of(context).toggleableActiveColor, // You can customize the color if needed
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 15),
//               const Divider(),
//               TableCalendar(
//                 eventLoader: _getChurchEventsForTheDay,
//                 calendarFormat: _calendarFormat3,
//                 onFormatChanged: (format) {
//                   setState(() {
//                     _calendarFormat3 = format;
//                   });
//                 },
//                 focusedDay: _focusedDay3,
//                 firstDay: _firstDay3,
//                 lastDay: _lastDay3,
//                 onPageChanged: (focusedDay) {
//                   setState(() {
//                     _focusedDay3 = focusedDay;
//                   });
//                 },
//                 selectedDayPredicate: (day) => isSameDay(day, _selectedDay3),
//                 onDaySelected: (selectedDay, focusedDay) async {
//                   setState(() {
//                     _selectedDay3 = selectedDay;
//                     _focusedDay3 = focusedDay;
//                   });
//                   await _loadFirestorechurchEvent(selectedDay);
//                 },
//                 calendarStyle: const CalendarStyle(
//                   weekendTextStyle: TextStyle(color: Colors.red),
//                   selectedDecoration:
//                   BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
//                 ),
//                 calendarBuilders: CalendarBuilders(
//                   headerTitleBuilder: (context, day) => Container(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(DateFormat('MMMM d, yyyy').format(day)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _churchEvents.length,
//                 itemBuilder: (context, index) {
//                   final day = _churchEvents.keys.elementAt(index);
//                   final churchEventsForDay = _churchEvents[day]!;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Events for ${DateFormat('MMMM d, yyyy').format(day)}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: churchEventsForDay.length,
//                         itemBuilder: (context, index) {
//                           final churchEvent = churchEventsForDay[index];
//                           return ListTile(
//                             title: Text(churchEvent.churchEventType),
//                             subtitle: Text(churchEvent.description),
//                             onTap: () async {
//                               final res = await Navigator.push<bool>(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => EditChurchEvent(
//                                     churchEvent: churchEvent,
//                                     firstDate: _firstDay3,
//                                     lastDate: _lastDay3,
//                                   ),
//                                 ),
//                               );
//                               if (res ?? false) {
//                                 _loadFirestorechurchEvent(_selectedDay3);
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }