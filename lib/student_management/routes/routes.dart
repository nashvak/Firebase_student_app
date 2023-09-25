import 'package:firebase/student_management/repositories/student/student_operation/pages/edit_screen.dart';
import 'package:firebase/student_management/repositories/student/student_operation/pages/profile_page/profile.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../repositories/authentication/login_signup/screens/login.dart';
import '../repositories/authentication/login_signup/screens/signup.dart';
import '../repositories/authentication/phone/phone_number.dart';
import '../repositories/authentication/phone/verifycode.dart';
import '../repositories/push_notification/firebase_api/notification.dart';
import '../repositories/student/home_page/home.dart';
import '../repositories/student/student_operation/pages/addscreen.dart';
import '../repositories/student/view_student_details/display_student_details.dart';

class Routes {
  var route = <String, WidgetBuilder>{
    '/': (context) => const CheckLoginOrNot(),
    'login': (context) => const LoginScreen(),
    'signup': (context) => const SignUp(),
    'home': (context) => const Home(),
    'phone': (context) => const PhoneVerification(),
    'verify': (context) => const VerifyCodeScreen(
          verificationId: 'verificationId',
        ),
    'addscreen': (context) => const AddScreen(),
    'student': (context) => StudentDetails(),
    'notification': (context) => const NotificationPage(),
    'edit': (context) => EditScreen(),
    'profile': (context) => ProfilePage(),
  };
}
