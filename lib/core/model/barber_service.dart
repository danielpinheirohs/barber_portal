import 'package:cloud_firestore/cloud_firestore.dart';

class BarberService {
  final String id;
  final String name;
  final String description;
  final int time;
  final double price;
  final double commission;

  BarberService(this.id, this.name, this.description, this.time, this.price, this.commission);

  factory BarberService.fromSnapshot(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return BarberService(
      doc.id,
      map['name'],
      map['description'],
      map['time'],
      map['price'],
      map['price'],
    );
  }
}
