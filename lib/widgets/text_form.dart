import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  TextForm({super.key,required this.hint,required this.controller,this.validator});
  String hint;
  TextEditingController controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint
      ),
      validator: validator,
    );
  }
}