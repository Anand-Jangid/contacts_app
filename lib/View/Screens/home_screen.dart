import 'package:contacts_app/View/Screens/contanct_detail_screen.dart';
import 'package:contacts_app/View/Widgets/contact_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  firstName: "Rahul",
                  lastName: "Jangid",
                );
              })
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     ContactTile(
          //         firstName: "Anand",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Abhishek",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Tarun",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       ),
          //     ContactTile(
          //         firstName: "Rahul",
          //         lastName: "Jangid",
          //       )

          //   ]))
          // SliverFixedExtentList(
          //   itemExtent: 10,
          //   delegate: SliverChildListDelegate([
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //     ContactTile(firstName: "Rahul", lastName: "Jangid",),
          //   ]),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ContactDetailScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
