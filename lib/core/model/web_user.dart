import 'dart:convert';

class WebUser {
  final String id;
  final String name;
  final String email;
  final String barberId;

  WebUser(this.id, this.name, this.email, this.barberId);

  factory WebUser.fromMap(Map<String, dynamic> map) {
    return WebUser(
      map['id'],
      map['name'],
      map['email'],
      map['barber_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'barber_id': barberId,
    };
  }

  factory WebUser.fromJson(String source) => WebUser.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
