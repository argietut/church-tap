import 'package:cloud_firestore/cloud_firestore.dart';

class ChurchEvent {
  final String id;
  final String description;
  final String churchEventType;
  final DateTime date;

  ChurchEvent({
    required this.id,
    required this.churchEventType,
    required this.description,
    required this.date,
  });

  factory ChurchEvent.fromFirestore(DocumentSnapshot doc, String id) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ChurchEvent(
      id: doc.id,
      churchEventType: data['churchEventType'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Future<void> update({
    required String churchEventType,
    required String description,
    required DateTime date,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('churchEvent').doc(id).update({
        'churchEventType': churchEventType,
        'description': description,
        'date': Timestamp.fromDate(date),
      });
    } catch (e) {
      print('Error updating church event: $e');
      rethrow;
    }
  }
}
