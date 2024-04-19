// import 'package:flutter/material.dart';
//
// import 'appointment_source.dart';
//
//
// class AppointmentItem extends StatelessWidget {
//   final Appointment appointment;
//   final Function() onDelete;
//   final Function()? onTap;
//   const AppointmentItem({
//     Key? key,
//     required this.appointment,
//     required this.onDelete,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         appointment.appointmenttype,
//       ),
//       subtitle: Text(
//         appointment.date.toString(),
//       ),
//       onTap: onTap,
//       trailing: IconButton(
//         icon: const Icon(Icons.delete),
//         onPressed: onDelete,
//       ),
//     );
//   }
// }