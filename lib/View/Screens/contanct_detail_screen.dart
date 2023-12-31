import 'dart:io';

import 'dart:typed_data';

import 'package:contacts_app/Constants/enums.dart';
import 'package:contacts_app/Constants/exceptions.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/Provider/contact_image_picker.dart';
import 'package:contacts_app/Provider/contact_provider.dart';
import 'package:contacts_app/View/Widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Utils/converter.dart';
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
  late File? imageData;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.contact?.firstName);
    _lastNameController = TextEditingController(text: widget.contact?.lastName);
    _phoneNumberController =
        TextEditingController(text: widget.contact?.phoneNumber);
    _emailController = TextEditingController(text: widget.contact?.email);
    imageData = (widget.contact?.imageData != null)
        ? File(widget.contact!.imageData!)
        : null;
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
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            ImageWidget(
              image: imageData,
              pickImageDialog: pickImagePopUp,
            ),
            TextFields(
              // initialValue: widget.contact?.firstName,
              label: 'First Name',
              controller: _firstNameController,
              prefixIcon: const Icon(Icons.person),
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
              prefixIcon: const Icon(Icons.person),
            ),
            TextFields(
              label: 'Phone Number',
              // initialValue: widget.contact?.phoneNumber,
              controller: _phoneNumberController,
              keyBoardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
              validator: (value) {
                if (value == null || value == "") {
                  return 'Phone Number is required';
                }
                if (!isValidPhoneNUmber(value)) {
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
              prefixIcon: const Icon(Icons.email),
              validator: (value) {
                if (value == "" || value == null) {
                  return null;
                }
                if (!isValidEmail(value)) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
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
                                : _emailController.text,
                            imageData: imageData?.path);
                        try {
                          await Provider.of<ContactProvider>(context,
                                  listen: false)
                              .addContact(contact);
                          Navigator.of(context).pop();
                        } on MyDatabaseException catch (e) {
                          ScaffoldMessenger.of(context)
                              .hideCurrentMaterialBanner();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.description)));
                        }
                      }
                    },
                    child: const Text('Save'),
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
                                    : _emailController.text,
                                imageData: imageData?.path);
                            try {
                              await Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .updateContact(widget.contact!.id!, contact);
                              Navigator.pop(context);
                            } on MyDatabaseException catch (e) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.description)));
                            }
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
                            await Provider.of<ContactProvider>(context,
                                    listen: false)
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

  Future showPopup(String title, String? content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: (content != null)
                ? Text(
                    content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : null,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(PopUpResponse.YES);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(PopUpResponse.NO);
                  },
                  child: const Text("No"))
            ],
          );
        });
  }

  Future pickImagePopUp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pick Image"),
            content: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text("Camera"),
                  onTap: () async {
                    var imageSelected = await ContactImagePicker()
                        .pickImage(ImageSource.camera);
                    if (imageSelected != null) {
                      // imageData = await fileToBlob(imageSelected);
                      imageData = imageSelected;
                      Navigator.of(context).pop(imageSelected);
                    } else {
                      throw "Error in selecting image";
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_album_rounded),
                  title: const Text("Gallery"),
                  onTap: () async {
                    var imageSelected = await ContactImagePicker()
                        .pickImage(ImageSource.gallery);
                    if (imageSelected != null) {
                      // imageData = await fileToBlob(imageSelected);
                      imageData = imageSelected;
                      Navigator.of(context).pop(imageSelected);
                    } else {
                      throw "Error in selecting image";
                    }
                  },
                )
              ]),
            ),
          );
        });
  }
}

class ImageWidget extends StatefulWidget {
  const ImageWidget(
      {super.key, required this.image, required this.pickImageDialog});

  final File? image;
  final Function pickImageDialog;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late File? newImage;

  @override
  void initState() {
    super.initState();
    newImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: IconButton(
        icon: (newImage != null)
            ? ClipOval(
                child: Container(
                    width: 140,
                    height: 140,
                    color: Colors.transparent,
                    child: Image.file(
                      newImage!,
                      fit: BoxFit.cover,
                    )))
            : const CircleAvatar(
                radius: 70,
                child: Icon(
                  Icons.add_a_photo_rounded,
                  size: 70,
                ),
              ),
        onPressed: () async {
          var pickedImage = await widget.pickImageDialog();
          // var selectedImage = await fileToBlob(pickedImage);
          setState(() {
            newImage = pickedImage;
          });
        },
      ),
    );
  }
}
