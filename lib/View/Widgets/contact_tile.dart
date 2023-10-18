import 'dart:math';
import 'package:contacts_app/View/Screens/contanct_detail_screen.dart';
import 'package:contacts_app/View/Widgets/circular_button.dart';
import 'package:flutter/material.dart';

import '../../Models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  ContactTile({super.key, required this.contact});

  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // color: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ExpansionTile(
          leading: CircleAvatar(
              backgroundColor: colorList[random.nextInt(10)],
              child: Text(contact.firstName[0])),
          title: Text('${contact.firstName} ${contact.lastName ?? ''}'),
          trailing: CircleAvatar(
              child: IconButton(
            icon: Icon(Icons.call_rounded),
            onPressed: () {},
          )),
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(contact.email ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(contact.phoneNumber),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularButton(
                      icons: Icons.call_rounded,
                      onPressed: () {},
                      title: "Call"),
                  CircularButton(
                      icons: Icons.email_rounded,
                      onPressed: () {},
                      title: "Email"),
                  CircularButton(
                      icons: Icons.edit_rounded,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactDetailScreen(
                                  contact: contact,
                                )));
                      },
                      title: "Edit"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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
