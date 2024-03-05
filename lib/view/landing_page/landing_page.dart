import 'package:firebase/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Lottie.asset('assets/lottie/landing_page_icon.json', height: 300),
              const Spacer(),
              Button(
                  title: 'Sign Up',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'signup');
                  }),
              const SizedBox(
                height: 30,
              ),
              OutlineButton(
                  title: 'Login',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
