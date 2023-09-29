import 'package:flutter/material.dart';

Widget studentTextform(String title, TextEditingController controller,
    Icon? icon, String? Function(String?)? validator, IconButton? sufficIcon) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(title),
        prefixIcon: icon,
        suffixIcon: sufficIcon),
    keyboardType: TextInputType.text,
    autocorrect: false,
    textCapitalization: TextCapitalization.none,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
  );
}
