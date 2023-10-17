import 'package:contacts_app/Models/contact.dart';
import 'package:flutter/material.dart';

import '../Widgets/contact_tile.dart';

class AllContactScreen extends StatefulWidget {
  const AllContactScreen({super.key});

  @override
  State<AllContactScreen> createState() => _AllContactScreenState();
}

class _AllContactScreenState extends State<AllContactScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "My Contacts",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
            pinned: true,
            expandedHeight: 200,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('asset/image/contacts.png')),
          ),
          SliverList.builder(
              itemCount: 200,
              itemBuilder: (context, index) {
                return ContactTile(
                  contact: Contact(firstName: "Anand", phoneNumber: "1234567890", lastName: "Jangid", email: "jangidme88@gmail.com"),
                );
              })

        ],
      );
  }
}