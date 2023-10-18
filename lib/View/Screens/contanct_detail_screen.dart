import 'package:contacts_app/Constants/enums.dart';
import 'package:contacts_app/Constants/exceptions.dart';
import 'package:contacts_app/Database/contact_database.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/Provider/contact_provider.dart';
import 'package:contacts_app/View/Widgets/circular_button.dart';
import 'package:contacts_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _firstNameController =
        TextEditingController(text: widget.contact?.firstName);
    _lastNameController = TextEditingController(text: widget.contact?.lastName);
    _phoneNumberController =
        TextEditingController(text: widget.contact?.phoneNumber);
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
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CircleAvatar(
                radius: 100,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 150,
                ),
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
            (widget.contact == null)
                ? ElevatedButton(
                    onPressed: () async {
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
                        try {
                          await Provider.of<ContactProvider>(context,
                                  listen: false)
                              .addContact(contact);
                          // Navigator.of(context).pop();
                        } on MyDatabaseException catch (e) {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.description)));
                        }
                      }
                    },
                    child: Text('Save'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularButton(
                        icons: Icons.update,
                        onPressed: () async {
                          var result = await showPopup(
                              "Update", "Do you want to update the contact?");
                          if (result == PopUpResponse.YES) {
                            Contact contact = Contact(
                                id: widget.contact!.id,
                                firstName: _firstNameController.text,
                                phoneNumber: _phoneNumberController.text,
                                lastName: _lastNameController.text == ""
                                    ? null
                                    : _lastNameController.text,
                                email: _emailController.text == ""
                                    ? null
                                    : _emailController.text);
                            await Provider.of<ContactProvider>(context, listen: false)
                                .updateContact(widget.contact!.id!, contact);
                            Navigator.pop(context);
                          }
                        },
                        title: "Update",
                        size: 35,
                      ),
                      CircularButton(
                        icons: Icons.delete,
                        onPressed: () async {
                          var result = await showPopup(
                              "Delete", "Do you want to delete the contact?");
                          if (result == PopUpResponse.YES) {
                            await Provider.of<ContactProvider>(context, listen: false)
                                .deleteContact(widget.contact!.id!);
                            Navigator.pop(context);
                          }
                        },
                        title: "Delete",
                        size: 35,
                      ),
                      CircularButton(
                        icons: Icons.share,
                        onPressed: () {},
                        title: "Share",
                        size: 35,
                      ),
                    ],
                  )
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

  Future showPopup(String title, String content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(PopUpResponse.YES);
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(PopUpResponse.NO);
                  },
                  child: Text("No"))
            ],
          );
        });
  }
}
