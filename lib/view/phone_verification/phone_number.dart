// ignore: file_names

import 'package:firebase/view_model/phone_services/phone_otp_provider.dart';
import 'package:firebase/widgets/textform.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final numberController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
//

    // verifyCode() {
    //   if (formKey.currentState!.validate()) {
    //     setState(() {
    //       isLoading = true;
    //     });
    //     auth.verifyPhoneNumber(
    //         phoneNumber: numberController.text,
    //         verificationCompleted: (_) {},
    //         verificationFailed: (e) {
    //           Utils().toastMessage(e.toString());
    //           setState(() {
    //             isLoading = false;
    //           });
    //         },
    //         codeSent: (String verificationId, int? token) {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => VerifyCodeScreen(
    //                         verificationId: verificationId,
    //                       )));
    //           setState(() {
    //             isLoading = false;
    //           });
    //         },
    //         codeAutoRetrievalTimeout: (e) {
    //           Utils().toastMessage(e.toString());
    //           setState(() {
    //             isLoading = false;
    //           });
    //         });
    //   }
    // }

//

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone verification"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 30),
            child: Text(
              "Enter your phone number",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  loginTextform(
                    '+91 1234567890',
                    numberController,
                    const Icon(Icons.phone_android),
                    TextInputType.phone,
                    null,
                    false,
                    (value) {
                      if (value!.isEmpty) {
                        return "Enter Phone Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Button(
                      title: 'Send Code',
                      onTap: () {
                        Provider.of<PhoneProvider>(context, listen: false)
                            .verifyPhone(numberController.text);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore