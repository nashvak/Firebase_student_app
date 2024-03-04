import 'package:firebase/view/landing_page/landing_page.dart';
import 'package:firebase/view/login_signup/login.dart';

import 'package:firebase/view_model/authentication_services/auth_provider.dart';
import 'package:firebase/view_model/image_provider/image_provider.dart';
import 'package:firebase/view_model/location_provider/location_provider.dart';

import 'package:firebase/view_model/phone_services/phone_otp_provider.dart';

import 'package:firebase/repositories/push_notification/firebase_api.dart';

import 'package:firebase/view/home_page/home.dart';
import 'package:firebase/view_model/student_services/student_provider.dart';
import 'package:firebase/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//navigate to pages without build context  used in the provider class
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<PhoneProvider>(
          create: (context) => PhoneProvider(),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider<ImageService>(
          create: (context) => ImageService(),
        ),
        ChangeNotifierProvider<LocationService>(
          create: (context) => LocationService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      //onGenerateRoute: generateRoute,
      navigatorKey: navigatorKey,
      routes: Routes().route,
      initialRoute: '/',
    );
  }
}

class CheckLoginOrNot extends StatefulWidget {
  const CheckLoginOrNot({super.key});

  @override
  State<CheckLoginOrNot> createState() => _CheckLoginOrNotState();
}

class _CheckLoginOrNotState extends State<CheckLoginOrNot> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LandingPage();
          } else {
            return const Home();
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
