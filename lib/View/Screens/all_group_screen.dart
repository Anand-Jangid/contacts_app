import 'package:flutter/material.dart';

class AllGroupScreen extends StatefulWidget {
  const AllGroupScreen({super.key});

  @override
  State<AllGroupScreen> createState() => _AllGroupScreenState();
}

class _AllGroupScreenState extends State<AllGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "My Groups",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            centerTitle: true,
            pinned: true,
            expandedHeight: 200,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('asset/image/contacts.png')),
          ),
          // SliverList.builder(
          //     itemCount: 200,
          //     itemBuilder: (context, index) {
          //       return ContactTile(
          //         contact: Contact(firstName: "Anand", phoneNumber: "1234567890", lastName: "Jangid", email: "jangidme88@gmail.com"),
          //       );
          //     })

        ],
      );
  }
}