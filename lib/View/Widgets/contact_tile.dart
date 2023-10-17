import 'dart:math';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String firstName;
  final String? lastName;
  final String? imagePath;
  ContactTile({super.key, required this.firstName, this.lastName, this.imagePath});

  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: colorList[random.nextInt(10)],
              child: Text(firstName[0])),
          title: Text('$firstName ${lastName ?? ''}'),
        ),
      ),
    );
  }

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.brown,
  ];
}
