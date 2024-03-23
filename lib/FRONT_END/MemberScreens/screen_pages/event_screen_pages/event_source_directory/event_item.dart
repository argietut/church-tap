import 'package:flutter/material.dart';
import 'event_source.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  final String eventType; // Add eventType parameter
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    required this.eventType, // Initialize eventType parameter
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        event.eventType,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.date.toString(),
          ),
          Text(
            'Event Type: $eventType', // Display eventType
          ),
        ],
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
