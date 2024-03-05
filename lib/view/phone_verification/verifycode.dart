import 'package:firebase/view_model/phone_services/phone_otp_provider.dart';
import 'package:firebase/constants/constants.dart';
import 'package:firebase/widgets/textform.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final verificationCodeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    // final auth = FirebaseAuth.instance;
    // var isLoading = false;

    //

    // verifyPhone() async {
    //   if (formKey.currentState!.validate()) {
    //     setState(() {
    //       isLoading = true;
    //     });
    //     final crendital = PhoneAuthProvider.credential(
    //         verificationId: widget.verificationId,
    //         smsCode: verificationCodeController.text.toString());
    //     setState(() {
    //       isLoading = false;
    //     });

    //     try {
    //       await auth.signInWithCredential(crendital);

    //       //ignore: use_build_context_synchronously
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => const Home()),
    //           (route) => false);
    //       setState(() {
    //         isLoading = false;
    //       });
    //     } catch (e) {
    //       Utils().toastMessage(e.toString());
    //       setState(() {
    //         isLoading = false;
    //       });
    //     }
    //   }
    // }

//

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              height50,
              loginTextform(
                'Enter 6 digit code',
                verificationCodeController,
                null,
                TextInputType.number,
                null,
                false,
                (value) {
                  if (value!.isEmpty) {
                    return "Enter Phone Number";
                  }
                  return null;
                },
              ),
              height50,
              Button(
                title: 'Verify',
                onTap: () async {
                  Provider.of<PhoneProvider>(context, listen: false)
                      .verifyOTP(verificationCodeController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
