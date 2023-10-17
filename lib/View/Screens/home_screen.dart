import 'package:contacts_app/View/Screens/all_contact_screen.dart';
import 'package:contacts_app/View/Screens/all_group_screen.dart';
import 'package:contacts_app/View/Screens/contanct_detail_screen.dart';
import 'package:contacts_app/View/Widgets/contact_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _screens = [
    AllContactScreen(),
    AllGroupScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_index == 0){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ContactDetailScreen()));
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            // indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )),
        child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: Duration(seconds: 1),
            selectedIndex: _index,
            onDestinationSelected: (value) {
              setState(() {
                _index = value;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.contacts_outlined), label: "All Contacts"),
              NavigationDestination(
                  icon: Icon(Icons.groups_outlined), label: "Group")
            ]),
      ),
    );
  }
}
