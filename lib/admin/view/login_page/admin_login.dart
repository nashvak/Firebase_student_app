import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/button.dart';
import '../../../widgets/textform.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green.shade900,
              Colors.green.shade800,
              Colors.green.shade400
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login to admin account",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: loginTextform(
                                  'email',
                                  emailController,
                                  const Icon(Icons.email),
                                  TextInputType.emailAddress,
                                  false,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return "Enter email";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              height10,
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: loginTextform(
                                  'Password',
                                  passwordController,
                                  const Icon(Icons.lock),
                                  TextInputType.text,
                                  true,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Pasword";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      height30,
                      Button(
                          title: 'Login',
                          //loading: _isLoading,
                          onTap: () {
                            if (formKey.currentState!.validate()) {}
                          }),
                    ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
