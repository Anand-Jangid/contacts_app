import 'dart:math';
import 'package:contacts_app/View/Screens/contanct_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../Models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  ContactTile(
      {super.key, required this.contact});

  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ContactDetailScreen(contact: contact,)));
        },
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: colorList[random.nextInt(10)],
                child: Text(contact.firstName[0])),
            title: Text('${contact.firstName} ${contact.lastName ?? ''}'),
          ),
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
