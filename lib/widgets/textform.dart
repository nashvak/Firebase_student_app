import 'package:flutter/material.dart';

Widget loginTextform(
    String title,
    TextEditingController controller,
    Icon? icon,
    TextInputType keyboardtype,
    BoxDecoration? decoration,
    bool obscure,
    String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
        border: InputBorder.none, label: Text(title), prefixIcon: icon),
    keyboardType: keyboardtype,
    autocorrect: false,
    textCapitalization: TextCapitalization.none,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
  );
}
