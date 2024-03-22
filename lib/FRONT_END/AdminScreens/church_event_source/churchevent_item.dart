import 'package:flutter/material.dart';

import 'church_event_source.dart';


class ChurchEventItem extends StatelessWidget {
  final  ChurchEvent churchEvent;
  final Function() onDelete;
  final Function()? onTap;
  const ChurchEventItem({
    Key? key,
    required this.churchEvent,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        churchEvent.churchEventType,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            churchEvent.date.toString(),
          ),
          Text(
            'Description: ${churchEvent.description}',
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
