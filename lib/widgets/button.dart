import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const Button(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

//constants

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: appColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                )
              : Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OutlineButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: appColor,
            )),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                  color: appColor, fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

//

Widget textbutton(String title, Color color, Function() onpressed) {
  return TextButton(
      onPressed: onpressed,
      child: Text(
        title,
        style: TextStyle(color: color),
      ));
}
