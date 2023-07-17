import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String ? Function(String?)? validator;
  TextEditingController? controller;
  Widget? prefixIcon;
  int? maxLines;
  CustomTextField({
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.09),
                blurRadius: 1)
          ]),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.cyan),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.cyanAccent, width: 2))),
      ),
    );
  }
}
