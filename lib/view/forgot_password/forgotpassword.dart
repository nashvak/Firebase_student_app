import 'package:firebase/widgets/button.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController emailController = TextEditingController();
  final forgotKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'Password Recovery',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter your email',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: forgotKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: Text('Email'),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(title: 'Send email', onTap: () {})
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
