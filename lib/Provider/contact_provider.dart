import 'dart:collection';

import 'package:contacts_app/Constants/exceptions.dart';
import 'package:contacts_app/Database/contact_database.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../locator.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  Future<void> addContact(Contact contact) async {
    try {
      await locator<ContactDatabase>().addContact(contact);
      getAllContacts();
    } on MyDatabaseException catch (e) {
      rethrow;
    }
  }

  Future<void> getAllContacts() async {
    var contacts = await locator<ContactDatabase>().getAllContacts();
    _contacts.clear();
    _contacts.addAll(contacts);
    notifyListeners();
  }

  Future<void> updateContact(int id, Contact contact) async {
    try {
      await locator<ContactDatabase>().updateContact(contact, id);
      getAllContacts();
    } on MyDatabaseException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContact(int id) async {
    await locator<ContactDatabase>().deleteContact(id);
    getAllContacts();
  }
}
