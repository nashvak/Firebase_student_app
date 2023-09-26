import 'dart:io';

import 'package:firebase/student_management/repositories/student/student_operation/models/models.dart';
import 'package:firebase/student_management/repositories/student/student_operation/services/student_services.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../reusablewidgets/constants.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseContoller = TextEditingController();
  final dobContoller = TextEditingController();
  final addressContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late Position currentPosition;
  String currentAddress = "My Address";
  File? file;

  XFile? pickedFile;

  // A C C E S S    I M A G E
  Future getImage(bool isCamera) async {
    final picker = ImagePicker();
    if (isCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      file = File(pickedFile!.path);
    });
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              "Permission for accessing location is denied,Please go to settings ,and on");
      Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("Longitude:${position.longitude}");
      print("Latitude:${position.latitude}");
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark place = placemarks[0];
        setState(() {
          currentPosition = position;
          currentAddress =
              "${place.locality},${place.postalCode},${place.country}";
          addressContoller.text = currentAddress;
          print(currentAddress);
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  //

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dobContoller.text = formattedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Add Student'),
        backgroundColor: Color(0xFFE5E5E5),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Height30,
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Take Photo'),
                                  onTap: () {
                                    getImage(true);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: const Text('Choose Photo'),
                                  onTap: () {
                                    getImage(false);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        //scolor: Colors.orange,
                        child: (file == null)
                            ? const Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.black,
                                      backgroundImage: AssetImage(
                                          'assets/images/user-logo.png'),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 89, 88, 88),
                                    ),
                                  )
                                ],
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(file!),
                              ),
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                    ),
                    Height10,
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Age',
                          prefixIcon: Icon(Icons.cake)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Age";
                        }
                        return null;
                      },
                    ),
                    Height10,
                    TextFormField(
                      controller: courseContoller,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Course',
                          prefixIcon: Icon(Icons.event_note_sharp)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter course";
                        }
                        return null;
                      },
                    ),
                    Height10,
                    TextFormField(
                      controller: dobContoller,
                      decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: ' Date of birth',
                          prefixIcon: const Icon(Icons.calendar_month),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                selectDate(context);
                              },
                              icon: const Icon(Icons.calendar_month))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Date of birth";
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 210,
                          child: TextField(
                            controller: addressContoller,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: ' Address',
                                prefixIcon: Icon(Icons.location_on)),
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter name";
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            getCurrentPosition();
                          },
                          child: Text("find"),
                        ),
                      ],
                    ),
                    Height30,
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (file == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please upload an image'),
                              ),
                            );

                            return;
                          }
                          if (formKey.currentState!.validate()) {
                            String name = nameController.text;
                            String age = ageController.text;
                            String course = courseContoller.text;
                            String dob = dobContoller.text;
                            String address = addressContoller.text;
                            Student st = Student(
                                name: name,
                                age: age,
                                course: course,
                                dob: dob,
                                dp: file,
                                address: address);

                            Provider.of<StudentProvider>(context, listen: false)
                                .createUser(st);

                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'student');
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
