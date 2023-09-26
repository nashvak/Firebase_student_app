import 'package:flutter/material.dart';

Widget customTextform(String title, TextEditingController controller,
    Icon? icon, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(), label: Text(title), prefixIcon: icon),
    keyboardType: TextInputType.text,
    autocorrect: false,
    textCapitalization: TextCapitalization.none,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
  );
}
