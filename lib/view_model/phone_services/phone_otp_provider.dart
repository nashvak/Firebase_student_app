import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

// class PhoneProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   void verifyPhone(String phoneNumber) {
//     _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (_) {},
//         verificationFailed: (e) {
//           Fluttertoast.showToast(
//               msg: e.message.toString(), gravity: ToastGravity.TOP);
//         },
//         codeSent: (String verificationId, int? token) {
//           navigatorKey.currentState
//               ?.pushNamed('verify', arguments: verificationId);
//         },
//         codeAutoRetrievalTimeout: (e) {
//           Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
//         });
//   }
// }

class PhoneProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  String? get verificationId => _verificationId;

  Future<void> verifyPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // Handle the error here, you could also notify listeners to reflect in UI.
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.TOP);
      },
      codeSent: (String verId, int? forceResendingToken) {
        _verificationId = verId;
        navigatorKey.currentState
            ?.pushNamed('verify', arguments: _verificationId);
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verId) {
        _verificationId = verId;

        notifyListeners();
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      // Handle successful verification here, and you can also notify listeners.
      navigatorKey.currentState?.pushNamed('home');
    } catch (e) {
      // Handle error here, and you can also notify listeners.
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }
}
