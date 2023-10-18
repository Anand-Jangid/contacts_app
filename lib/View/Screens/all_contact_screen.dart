import 'package:contacts_app/Database/contact_database.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/locator.dart';
import 'package:flutter/material.dart';

import '../Widgets/contact_tile.dart';

class AllContactScreen extends StatefulWidget {
  const AllContactScreen({super.key});

  @override
  State<AllContactScreen> createState() => _AllContactScreenState();
}

class _AllContactScreenState extends State<AllContactScreen> {

  Future<List<Contact>> fetchData() async {
    await Future.delayed(const Duration(microseconds: 500));
    return [
      Contact(
          firstName: "John",
          lastName: "Doe",
          phoneNumber: "(123) 456-7890",
          email: "john.doe@example.com"),
      Contact(
          firstName: "Alice",
          lastName: "Smith",
          phoneNumber: "(987) 654-3210",
          email: "alice.smith@example.com"),
      Contact(
          firstName: "Robert",
          lastName: "Johnson",
          phoneNumber: "(555) 123-4567",
          email: "robert.johnson@example.com"),
      Contact(
          firstName: "Emily",
          lastName: "Wilson",
          phoneNumber: "(777) 888-9999",
          email: "emily.wilson@example.com"),
      Contact(
          firstName: "Michael",
          lastName: "Davis",
          phoneNumber: "(555) 123-9876",
          email: "michael.davis@example.com"),
      Contact(
          firstName: "John",
          lastName: "Doe",
          phoneNumber: "(123) 456-7890",
          email: "john.doe@example.com"),
      Contact(
          firstName: "Alice",
          lastName: "Smith",
          phoneNumber: "(987) 654-3210",
          email: "alice.smith@example.com"),
      Contact(
          firstName: "Robert",
          lastName: "Johnson",
          phoneNumber: "(555) 123-4567",
          email: "robert.johnson@example.com"),
      Contact(
          firstName: "Emily",
          lastName: "Wilson",
          phoneNumber: "(777) 888-9999",
          email: "emily.wilson@example.com"),
      Contact(
          firstName: "Michael",
          lastName: "Davis",
          phoneNumber: "(555) 123-9876",
          email: "michael.davis@example.com"),
      Contact(
          firstName: "John",
          lastName: "Doe",
          phoneNumber: "(123) 456-7890",
          email: "john.doe@example.com"),
      Contact(
          firstName: "Alice",
          lastName: "Smith",
          phoneNumber: "(987) 654-3210",
          email: "alice.smith@example.com"),
      Contact(
          firstName: "Robert",
          lastName: "Johnson",
          phoneNumber: "(555) 123-4567",
          email: "robert.johnson@example.com"),
      Contact(
          firstName: "Emily",
          lastName: "Wilson",
          phoneNumber: "(777) 888-9999",
          email: "emily.wilson@example.com"),
      Contact(
          firstName: "Michael",
          lastName: "Davis",
          phoneNumber: "(555) 123-9876",
          email: "michael.davis@example.com"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator<ContactDatabase>().getAllContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available.'));
        }
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ContactTile(
                    contact: snapshot.data![index],
                  );
                })
          ],
        );
      },
    );
  }
}
