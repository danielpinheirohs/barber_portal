import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String id;
  final String name;
  final String phone;

  Customer(this.id, this.name, this.phone);

  factory Customer.fromSnapshot(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return Customer(
      doc.id,
      map['name'],
      map['phone'],
    );
  }
}
