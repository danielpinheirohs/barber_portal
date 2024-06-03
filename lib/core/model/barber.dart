import 'dart:convert';

class Barber {
  final String id;
  final String name;
  final String phone;
  final String ownerId;

  Barber(this.id, this.name, this.phone, this.ownerId);

  factory Barber.fromMap(Map<String, dynamic> map) {
    return Barber(
      map['id'],
      map['name'],
      map['phone'],
      map['owner_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'owner_id': ownerId,
    };
  }

  factory Barber.fromJson(String source) => Barber.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
