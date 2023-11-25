import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.icon, this.controller, this.hintText});
  final Icon? icon;
  final String? hintText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: icon,
      ),
      controller: controller,
    );
  }
}
