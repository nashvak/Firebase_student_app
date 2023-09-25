import 'package:firebase/student_management/reusablewidgets/button.dart';

import 'package:firebase/student_management/reusablewidgets/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../reusablewidgets/textform.dart';

import '../services/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // FirebaseAuth auth = FirebaseAuth.instance;
  // var _isLoading = false;

//function to login

//   void login() {
//     setState(() {
//       _isLoading = true;
//     });
//     auth
//         .signInWithEmailAndPassword(
//             email: emailController.text,
//             password: passwordController.text.toString())
//         .then((value) {
//       setState(() {
//         _isLoading = false;
//       });
//       Utils().toastMessage('log in succesfully');
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Home()),
//           (route) => false);
//     }).onError((error, stackTrace) {
//       debugPrint(error.toString());
//       Utils().toastMessage(error.toString());
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

// //

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return WillPopScope(
      //when we click back button in android phone the app should be exited
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
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
                    Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 40)),
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
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: textform(
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
                                Height10,
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: textform(
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
                        Height10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Height10,
                        Button(
                            title: 'Login',
                            //loading: _isLoading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authService.signInWithEmail(
                                    emailController.text,
                                    passwordController.text);
                              }
                            }),
                        Height50,
                        const Text(
                          "OR",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Height30,
                        OutlineButton(
                            title: 'Sign in with Phone number',
                            onTap: () {
                              Navigator.of(context).pushNamed('phone');
                            }),
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?",
                style: TextStyle(color: Colors.green)),
            textbutton(
              'SignUp',
              Colors.green,
              () => Navigator.pushNamed(context, 'signup'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
