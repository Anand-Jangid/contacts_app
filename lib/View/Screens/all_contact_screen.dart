import 'package:contacts_app/Provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/contact_tile.dart';

class AllContactScreen extends StatefulWidget {
  const AllContactScreen({super.key});

  @override
  State<AllContactScreen> createState() => _AllContactScreenState();
}

class _AllContactScreenState extends State<AllContactScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ContactProvider>(context, listen: false).getAllContacts();
  }

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
        ContactLists()
      ],
    );
    // },
  }
}

class ContactLists extends StatelessWidget {
  ContactLists({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ContactProvider>(context, listen: false).getAllContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator())
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Center(child: Text('Error: ${snapshot.error}')));
        }
        return Consumer<ContactProvider>(
          builder: (context, value, child) {
            return SliverList.builder(
                itemCount: value.contacts.length,
                itemBuilder: (context, index) {
                  return ContactTile(contact: value.contacts[index]);
                });
          },
        );
      },
    );
  }
}
