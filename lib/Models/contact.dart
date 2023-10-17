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
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      firstName: map['firstName'] as String,
      phoneNumber : map['phoneNumber'] as String,
      id: map['id'] != null ? map['id'] as int : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
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
