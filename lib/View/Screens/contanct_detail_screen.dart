import 'package:contacts_app/Models/contact.dart';
import 'package:flutter/material.dart';

import '../Widgets/text_field.dart';

class ContactDetailScreen extends StatefulWidget {
  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 200,
              ),
            ),
            TextFields(
              label: 'First Name',
              controller: _firstNameController,
              prefixIcon: Icon(Icons.person),
              keyBoardType: TextInputType.name,
              validator: (value) {
                if (value == "" || value == null) {
                  return 'First Name is required';
                }
                return null;
              },
            ),
            TextFields(
              label: 'Last Name',
              controller: _lastNameController,
              keyBoardType: TextInputType.name,
              prefixIcon: Icon(Icons.person),
            ),
            TextFields(
              label: 'Phone Number',
              controller: _phoneNumberController,
              keyBoardType: TextInputType.phone,
              prefixIcon: Icon(Icons.phone),
              validator: (value) {
                if (value == null || value == "") {
                  return 'Phone Number is required';
                }
                if (!isValidPhoneNUmber(value!)) {
                  return "Invalid Phone Number";
                }
                return null;
              },
            ),
            TextFields(
              label: 'Email',
              controller: _emailController,
              keyBoardType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email),
              validator: (value) {
                if (value == "" || value == null) {
                  return null;
                }
                if (!isValidEmail(value!)) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Contact contact = Contact(
                      firstName: _firstNameController.text,
                      phoneNumber: _phoneNumberController.text,
                      lastName: _lastNameController.text == "" ? null : _lastNameController.text,
                      email: _emailController.text == "" ? null : _emailController.text
                  );
                  print(contact);
                  //TODO: Save the contact
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNUmber(String phoneNumber) {
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    if (phoneNumber.length < 10) {
      return false;
    } else if (!phoneRegex.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }
}
