import 'dart:math';
import 'package:contacts_app/View/Screens/contanct_detail_screen.dart';
import 'package:contacts_app/View/Widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/contact.dart';

class ContactTile extends StatefulWidget {
  final Contact contact;
  ContactTile({super.key, required this.contact});

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  var random = Random();

  bool _expandTile = false;

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
          onExpansionChanged: (value) {
            setState(() {
              _expandTile = value;
            });
          },
          leading: CircleAvatar(
              backgroundColor: colorList[random.nextInt(10)],
              child: Text(widget.contact.firstName[0])),
          title: Text(
              '${widget.contact.firstName} ${widget.contact.lastName ?? ''}'),
          trailing: (_expandTile) ? Icon(Icons.keyboard_arrow_up_outlined) :Icon(Icons.keyboard_arrow_down_outlined),
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(widget.contact.email ?? ""),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(widget.contact.phoneNumber),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularButton(
                      icons: Icons.call_rounded,
                      onPressed: () async {
                        await _launchPhone();
                      },
                      title: "Call"),
                  CircularButton(
                      icons: Icons.email_rounded,
                      onPressed: () async {
                        await _launchEmail();
                      },
                      title: "Email"),
                  CircularButton(
                      icons: Icons.sms_rounded,
                      onPressed: () async {
                        await _launchSMS();
                      },
                      title: "SMS"),
                  CircularButton(
                      icons: Icons.edit_rounded,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactDetailScreen(
                                  contact: widget.contact,
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

  Future _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: widget.contact.phoneNumber);
    return await launchUrl(phoneUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: widget.contact.email,
      // query: encodeQueryParameters(<String, String>{
      //   'subject': 'Example Subject & Symbols are allowed!',
      // }),
    );
    launchUrl(emailUri);
  }

  Future _launchSMS() async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: widget.contact.phoneNumber,
      // queryParameters: <String, String>{
      //   'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
      // },
    );
    launchUrl(smsLaunchUri);
  }
}
