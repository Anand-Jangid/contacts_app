import 'dart:io';
import 'dart:typed_data';

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
        image_data TEXT,
        last_name TEXT,
        email TEXT UNIQUE,
        phone TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<int> addContact(Contact contact,) async {
    try {
      if(contact.imageData != null){
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        String? oldPath = contact.imageData;
        String newPath = "$appDocPath/${DateTime.timestamp().millisecondsSinceEpoch}.jpg";
        contact.imageData = newPath;
        File oldImageFile = File(oldPath!);
        await oldImageFile.copy(newPath);
        oldImageFile.delete();
      }
      int result = await _db.insert(table, contact.toMap());
      return result;
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw MyDatabaseException("Unique Constraint Error", e.toString());
      } else {
        rethrow;
      }
    }
  }

  Future<List<Contact>> getAllContacts() async {
    try {
      final contactsMap = await _db.query(table,
          orderBy: "first_name",
          columns: [
            'contact_id',
            'first_name',
            'last_name',
            'email',
            'phone',
            'image_data'
          ]);
      //!Fetching image from the path

      final resultContact = contactsMap.map((e) => Contact.fromMap(e)).toList();
      // File imageFile = File(resultContact[0].imageData!);
      return resultContact;
    } catch (e) {
      throw e;
    }
  }

  Future<int> updateContact(Contact contact, int id) async {
    try {
      //Check if the image is changed or not
      final oldContact = await _db.query(table, where: 'contact_id = ?', whereArgs: [id]);
      if(oldContact[0]['image_data'] != contact.imageData){
        //Image is chnaged
        //Check if is now null or nor
        //If it is null then we need to delete image from memeory
        //eles we need to store new image
        if(oldContact[0]['image_data'] != null){
          await deleteImage(oldContact[0]['image_data'] as String);
        }
        if(contact.imageData != null){
          Directory appDoc = await getApplicationDocumentsDirectory();
          String appDocPath = appDoc.path;
          String newImagePath = "$appDocPath/${DateTime.timestamp().millisecondsSinceEpoch}.jpg";
          String? cachePath = contact.imageData;
          contact.imageData = newImagePath;
          File oldImageFile = File(cachePath!);
          await oldImageFile.copy(newImagePath);
          oldImageFile.delete();
        }

      }
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
      //First delete image from main memory if exists
      final contact = await _db.query(table, where: 'contact_id = ?', whereArgs: [id]);
      if(contact[0]['image_data'] != null){
        await deleteDatabase(contact[0]['image_data'] as String);
      }
      return await _db.delete(table, where: 'contact_id = ?', whereArgs: [id]);
    } catch (e) {
      throw e;
    }
  }

  Future deleteImage(String imagePath)async{
    try{
      File imageToBeDeleted = File(imagePath);
      await imageToBeDeleted.delete();
    }catch(e){
      rethrow;
    }
  }
}
