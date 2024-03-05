import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Function for login
  Future signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      navigatorKey.currentState?.pushNamed('home');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.TOP);
      return null;
    }
  }

//Function for signup
  Future createAccount(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigatorKey.currentState?.pop();
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message.toString(), gravity: ToastGravity.TOP);
      return null;
    }
  }

  //Function for reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: 'Password reset email has been sent !',
          gravity: ToastGravity.TOP);
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('login', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(
            msg: 'No user found for the email', gravity: ToastGravity.TOP);
      }
    }
  }

//Function for signout
  Future signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
