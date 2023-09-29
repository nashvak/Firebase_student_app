// import 'package:firebase/student_management/reusablewidgets/constants.dart';

// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final formKey = GlobalKey<FormState>();
// //

// //

//   // File? file;
//   // String? imageURL;
//   // late Reference imagetoUploadRef;

//   // Future getImage() async {
//   //   final picker = ImagePicker();
//   //   XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     file = File(pickedFile!.path);
//   //   });

//   //   uploadFile();
//   //   return;
//   // }

//   // Future uploadFile() async {
//   //   if (file != null) {
//   //     DateTime.now().millisecondsSinceEpoch.toString();

//   //     String url = args['imageUrl'];
//   //     imagetoUploadRef = FirebaseStorage.instance.refFromURL(url);

//   //     try {
//   //       await imagetoUploadRef.putFile(file!);
//   //       imageURL = await imagetoUploadRef.getDownloadURL();
//   //     } catch (error) {
//   //       //print(error);
//   //     }
//   //   }
//   // }

//   //
//   // void editProfile() {
//   //   showModalBottomSheet(
//   //       context: context,
//   //       builder: (context) {
//   //         return Scaffold(
//   //           body: Padding(
//   //             padding: const EdgeInsets.all(20),
//   //             child: SingleChildScrollView(
//   //               child: Column(
//   //                 mainAxisSize: MainAxisSize.min,
//   //                 children: <Widget>[
//   //                   const SizedBox(
//   //                     height: 50,
//   //                   ),
//   //                   GestureDetector(
//   //                     child: CircleAvatar(
//   //                       radius: 40,
//   //                       backgroundImage: NetworkImage(
//   //                         args['imageUrl'],
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   const SizedBox(
//   //                     height: 20,
//   //                   ),
//   //                   Container(
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.grey.shade200,
//   //                       border: Border.all(color: Colors.blueGrey),
//   //                       borderRadius: BorderRadius.circular(10),
//   //                     ),
//   //                     child: Padding(
//   //                       padding: const EdgeInsets.all(8.0),
//   //                       child: Column(
//   //                         children: [
//   //                           TextFormField(
//   //                             controller: nameController,
//   //                           ),
//   //                           TextFormField(
//   //                             controller: ageController,
//   //                           ),
//   //                           TextFormField(
//   //                             controller: courseContoller,
//   //                           ),
//   //                           TextFormField(
//   //                             controller: dobContoller,
//   //                           ),
//   //                           TextFormField(
//   //                             controller: addressContoller,
//   //                             decoration: const InputDecoration(
//   //                                 border: InputBorder.none),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   const SizedBox(
//   //                     height: 30,
//   //                   ),
//   //                   GestureDetector(
//   //                     onTap: () {
//   //                       Provider.of<StudentProvider>(context)
//   //                           .deleteStudent(args['name']);
//   //                     },
//   //                     child: Container(
//   //                       height: 40,
//   //                       width: double.infinity,
//   //                       decoration: BoxDecoration(
//   //                           color: Colors.grey.shade200,
//   //                           borderRadius: BorderRadius.circular(10),
//   //                           border: Border.all(color: Colors.grey)),
//   //                       child: const Center(
//   //                         child: Text(
//   //                           "Delete Account",
//   //                           style: TextStyle(color: Colors.red, fontSize: 18),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   )
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           floatingActionButton: SizedBox(
//   //             height: 70,
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //               children: [
//   //                 Container(
//   //                   transform: Matrix4.translationValues(
//   //                       -20, 0, 0), // translate up by 30
//   //                   child: GestureDetector(
//   //                     onTap: () {
//   //                       // do stuff
//   //                       print('doing stuff');
//   //                     },
//   //                     child: Text('Cancel'),
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   transform: Matrix4.translationValues(
//   //                       10, 0, 0), // translate up by 30
//   //                   child: const Text(
//   //                     'Edit Profile',
//   //                     style:
//   //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   transform: Matrix4.translationValues(
//   //                       50, 0, 0), // translate up by 30
//   //                   child: GestureDetector(
//   //                     onTap: () {
//   //                       // do stuff
//   //                       print('doing stuff');
//   //                     },
//   //                     child: const Text(
//   //                       'Save',
//   //                       style: TextStyle(
//   //                           fontSize: 17, fontWeight: FontWeight.bold),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           // dock it to the center top (from which it is translated)
//   //           floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//   //         );
//   //       });
//   // }

//   // //

//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as Map;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Navigator.pushNamed(context, 'edit', arguments: args);
//             },
//           )
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: 180,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: NetworkImage(args['imageUrl']),
//                   ),
//                 ),
//                 Height10,
//                 Text(
//                   args['name'],
//                   style: const TextStyle(fontSize: 25),
//                 ),
//                 Text(
//                   args['course'],
//                   style: const TextStyle(fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 70,
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 20,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Center(
//                         child: ListTile(
//                           onTap: () {},
//                           leading: const Icon(
//                             Icons.my_library_books,
//                             size: 30,
//                           ),
//                           title: const Text(
//                             "Review",
//                             style: TextStyle(fontSize: 25),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 30),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Height30,
//                   SizedBox(
//                     height: 70,
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 20,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Center(
//                         child: ListTile(
//                           onTap: () {},
//                           leading: const Icon(
//                             Icons.location_on,
//                             size: 30,
//                           ),
//                           title: const Text(
//                             "Location",
//                             style: TextStyle(fontSize: 25),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 30),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Height30,
//                   SizedBox(
//                     height: 70,
//                     child: Card(
//                       color: Colors.white,
//                       elevation: 20,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Center(
//                         child: ListTile(
//                           onTap: () {},
//                           leading: const Icon(
//                             Icons.calendar_month_outlined,
//                             size: 30,
//                           ),
//                           title: const Text(
//                             "Attendance",
//                             style: TextStyle(fontSize: 25),
//                           ),
//                           trailing: const Icon(Icons.arrow_forward_ios_rounded,
//                               size: 30),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
