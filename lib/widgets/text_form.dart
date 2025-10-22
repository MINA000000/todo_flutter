import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  TextForm({super.key,required this.hint,required this.controller});
  String hint;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint
      ),
    );
  }
}