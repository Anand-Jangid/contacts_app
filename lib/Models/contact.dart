// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  int? id;
  String firstName;
  String? lastName;
  String? email;
  String phoneNumber;

  Contact({
    required this.firstName,
    required this.phoneNumber,
    this.id,
    this.lastName,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contact_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      firstName: map['first_name'] as String,
      phoneNumber : map['phone'] as String,
      id: map['contact_id'] != null ? map['contact_id'] as int : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber)';
  }
}
