import 'package:contacts_app/Models/contact.dart';
import 'package:flutter/material.dart';

import '../Widgets/text_field.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({super.key, this.contact});
  final Contact? contact;
  @override
  _ContactDetailScreenState createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.contact?.firstName);
    _lastNameController = TextEditingController(text: widget.contact?.lastName);
    _phoneNumberController = TextEditingController(text: widget.contact?.phoneNumber);
    _emailController = TextEditingController(text: widget.contact?.email);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
  }

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
              // initialValue: widget.contact?.firstName,
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
              // initialValue: widget.contact?.lastName,
              controller: _lastNameController,
              keyBoardType: TextInputType.name,
              prefixIcon: Icon(Icons.person),
            ),
            TextFields(
              label: 'Phone Number',
              // initialValue: widget.contact?.phoneNumber,
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
              // initialValue: widget.contact?.email,
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
                      lastName: _lastNameController.text == ""
                          ? null
                          : _lastNameController.text,
                      email: _emailController.text == ""
                          ? null
                          : _emailController.text);
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
