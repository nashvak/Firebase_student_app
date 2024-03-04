import 'package:firebase/widgets/button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
                title: 'Sign Up',
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                }),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
                title: 'Login',
                onTap: () {
                  Navigator.pushNamed(context, 'signup');
                })
          ],
        ),
      ),
    );
  }
}
