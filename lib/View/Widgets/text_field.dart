import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  TextFields(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      required this.prefixIcon,
      required this.keyBoardType});
  final String label;
  final TextEditingController controller;
  String? Function(String?)? validator;
  final Icon prefixIcon;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)))
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
