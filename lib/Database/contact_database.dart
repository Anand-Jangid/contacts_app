import 'package:contacts_app/Constants/exceptions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/contact.dart';

class ContactDatabase {
  static const _databaseName = "Contancts.db";
  static const _databaseVersion = 1;

  static const table = "Contacts";

  late Database _db;

  Future<void> init() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    _db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Contacts (
        contact_id INTEGER PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT,
        email TEXT,
        phone TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<int> addContact(Contact contact) async {
    try {
      int result = await _db.insert(table, contact.toMap());
      return result;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        // String message =
        throw MyDatabaseException("Unique Constraint Error", e.toString());
      } else {
        rethrow;
      }
    }
  }

  Future<List<Contact>> getAllContacts() async {
    try {
      final contactsMap = await _db.query(table, orderBy: "first_name");
      final result = contactsMap.map((e) => Contact.fromMap(e)).toList();
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<int> updateContact(Contact contact, int id) async {
    try {
      int result = await _db.update(table, contact.toMap(),
          where: 'contact_id = ?', whereArgs: [id]);
      return result;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw MyDatabaseException("Unique Constraint Error", e.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<int> deleteContact(int id) async {
    try {
      return await _db.delete(table, where: 'contact_id = ?', whereArgs: [id]);
    } catch (e) {
      throw e;
    }
  }
}
