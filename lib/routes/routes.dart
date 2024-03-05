import 'package:firebase/view/forgot_password/forgotpassword.dart';
import 'package:firebase/view/student_crud/edit_screen.dart';

import 'package:flutter/material.dart';

import '../main.dart';
import '../view/login_signup/login.dart';
import '../view/login_signup/signup.dart';
import '../view/phone_verification/phone_number.dart';
import '../view/phone_verification/verifycode.dart';
import '../view/notification_ui/notification.dart';
import '../view/home_page/home.dart';
import '../view/student_crud/addscreen.dart';
import '../view/student_crud/display_student_details.dart';

class Routes {
  var route = <String, WidgetBuilder>{
    '/': (context) => const CheckLoginOrNot(),
    'login': (context) => const LoginScreen(),
    'signup': (context) => const SignUp(),
    'forgot_password': (context) => ForgotPassword(),
    'home': (context) => const Home(),
    'phone': (context) => const PhoneVerification(),
    'verify': (context) => const VerifyCodeScreen(
          verificationId: 'verificationId',
        ),
    'addscreen': (context) => const AddScreen(),
    'student': (context) => StudentDetails(),
    'notifications': (context) => const NotificationPage(),
    'edit': (context) => const EditScreen(),
  };
}
