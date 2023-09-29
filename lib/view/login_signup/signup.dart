import 'package:firebase/view/login_signup/login.dart';

import 'package:firebase/widgets/button.dart';

import 'package:firebase/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/textform.dart';
import '../../view_model/authentication_services/auth_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // var isLoading = false;
    //

    // void signin() {
    //   if (formKey.currentState!.validate()) {
    //     setState(() {
    //       isLoading = true;
    //     });
    //     auth
    //         .createUserWithEmailAndPassword(
    //             email: emailController.text.toString(),
    //             password: passwordController.text.toString())
    //         .then((value) {
    //       setState(() {
    //         isLoading = false;
    //       });
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => const Home()),
    //           (route) => false);
    //     }).onError((error, stackTrace) {
    //       Utils().toastMessage(error.toString());
    //       setState(() {
    //         isLoading = false;
    //       });
    //     });
    //   }
    // }

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.green.shade500,
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 30, bottom: 20, left: 20, right: 20),
                              width: 150,
                              child: Image.asset('assets/images/logo.png')),
                          loginTextform(
                            'email',
                            emailController,
                            const Icon(Icons.email),
                            TextInputType.emailAddress,
                            false,
                            (value) {
                              bool emailRegx = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);

                              if (value.isEmpty) {
                                return "Enter email";
                              }

                              if (!emailRegx) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                          ),
                          height10,
                          loginTextform(
                            'phone number',
                            numberController,
                            const Icon(Icons.phone_android_outlined),
                            TextInputType.number,
                            false,
                            (value) {
                              if (value!.isEmpty) {
                                return "Enter Phone Number";
                              } else if (numberController.text.length != 10) {
                                return "Enter valid number";
                              }
                              return null;
                            },
                          ),
                          height10,
                          loginTextform(
                              'password',
                              passwordController,
                              const Icon(Icons.lock),
                              TextInputType.text,
                              true, (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (passwordController.text.length < 8) {
                              return "Password should contain atleast 8 characters";
                            }
                            return null;
                          }),
                          height30,
                          Button(
                            title: 'Sign Up',
                            //loading: isLoading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authService.createAccount(
                                    emailController.text.toString(),
                                    passwordController.text.toString());
                              }
                            },
                          ),
                          height30
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: Colors.white)),
                    textbutton(
                        'Login',
                        Colors.white,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
