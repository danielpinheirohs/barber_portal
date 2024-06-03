import 'package:cloud_firestore/cloud_firestore.dart';

class Professional {
  final String id;
  final String name;
  final String phone;
  final String email;

  Professional(this.id, this.name, this.phone, this.email);

  factory Professional.fromMap(Map<String, dynamic> map) {
    return Professional(
      map['id'],
      map['name'],
      map['phone'],
      map['email'],
    );
  }

  factory Professional.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Professional(
      documentSnapshot.id,
      map['name'],
      map['phone'],
      map['email'],
    );
  }
}
