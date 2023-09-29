import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.backgroundColor, required this.title, super.key});
  final String title;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: backgroundColor, fontSize: 18),
        ),
      ),
    );
  }
}
