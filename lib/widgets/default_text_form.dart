import 'package:flutter/material.dart';

class DefaultTextForm extends StatefulWidget {
  DefaultTextForm({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });
  String hint;
  TextEditingController controller;
  String? Function(String?)? validator;
  bool isPassword;

  @override
  State<DefaultTextForm> createState() => _DefaultTextFormState();
}

class _DefaultTextFormState extends State<DefaultTextForm> {
  late bool obsecure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  obsecure = !obsecure;
                  setState(() {});
                },
                icon: Icon(obsecure ? Icons.visibility : Icons.visibility_off),
              )
            : null,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
