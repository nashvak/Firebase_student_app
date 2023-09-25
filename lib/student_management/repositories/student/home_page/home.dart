import 'dart:math';

import 'package:firebase/student_management/repositories/student/home_page/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             height: 300,
      //             width: double.infinity,
      //             child: Lottie.asset('assets/lottie/logo.json'),
      //           ),
      //           Height50,
      //           Height30,
      // Expanded(
      //   child: GridView.count(
      //     crossAxisCount: 2,
      //     children: [
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, 'addscreen');
      //         },
      //         child: const Card(
      //           elevation: 15,
      //           color: Colors.white,
      //           child: Center(
      //             child: Text(
      //               "Add Student",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, 'addscreen');
      //         },
      //         child: const Card(
      //           elevation: 15,
      //           color: Colors.white,
      //           child: Center(
      //             child: Text(
      //               "Add Student",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     SizedBox(
      //       height: 150,
      //       width: 150,
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, 'addscreen');
      //         },
      //         child: const Card(
      //           elevation: 15,
      //           color: Colors.white,
      //           child: Center(
      //             child: Text(
      //               "Add Student",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 150,
      //       width: 150,
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, 'student');
      //         },
      //         child: const Card(
      //           elevation: 15,
      //           color: Colors.white,
      //           child: Center(
      //                         child: Text("View Student",
      //                             style: TextStyle(fontSize: 18)),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             )
      //           ],
      //         ),
      //       )),
      //
      //

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            Cards(
              title: 'Profiles',
              icon: const Icon(Icons.person, size: 50),
              ontap: () {
                Navigator.pushNamed(context, 'student');
              },
            ),
            Cards(
                title: 'Tasks',
                icon: const Icon(Icons.task, size: 50),
                ontap: () {}),
            Cards(
                title: 'Attendance',
                icon: const Icon(Icons.calendar_month_rounded, size: 50),
                ontap: () {}),
            Cards(
                title: 'Exam',
                icon: const Icon(Icons.note_alt, size: 50),
                ontap: () {}),
            Cards(
                title: 'Assignments',
                icon: const Icon(
                  Icons.assignment,
                  size: 50,
                ),
                ontap: () {}),
            Cards(
                title: 'Fees',
                icon: const Icon(Icons.money, size: 50),
                ontap: () {}),
            Cards(
                title: 'Notifications',
                icon: const Icon(Icons.notification_add, size: 50),
                ontap: () {}),
            Cards(
                title: 'Settings',
                icon: const Icon(Icons.settings, size: 50),
                ontap: () {}),
          ],
        ),
      ),

      drawer: const DrawerWidget(),
    );
  }
}

class Cards extends StatelessWidget {
  Cards(
      {super.key,
      required this.title,
      required this.icon,
      required this.ontap});
  final void Function() ontap;
  final String title;
  Icon icon;
  final List<Color> colors = [
    const Color(0xFFCCE5FF), // light blue
    const Color(0xFFD7F9E9), // pale green
    const Color(0xFFFFF8E1), // pale yellow
    const Color(0xFFF5E6CC), // beige
    const Color(0xFFFFD6D6), // light pink
    const Color(0xFFE5E5E5), // light grey
    const Color(0xFFFFF0F0), // pale pink
    const Color(0xFFE6F9FF), // pale blue
    const Color(0xFFD4EDDA), // mint green
    const Color(0xFFFFF3CD),
  ];
  getRandomColors() {
    Random random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 15,
        color: getRandomColors(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
