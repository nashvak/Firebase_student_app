import 'dart:io';

import 'package:firebase/student_management/repositories/student/student_operation/models/models.dart';
import 'package:firebase/student_management/repositories/student/student_operation/services/student_services.dart';
import 'package:firebase/student_management/repositories/student/student_operation/widgets/textform.dart';
import 'package:firebase/student_management/repositories/student/student_operation/widgets/validators.dart';

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

  // A C C E S S   C U R R E N T   L O C A T I O N

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              "Permission for accessing location is denied,Please go to settings and turn on");
      Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // print("Longitude:${position.longitude}");
      // print("Latitude:${position.latitude}");
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

  //  S E L E C T  D A T E  O F   B I R T H

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2024),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dobContoller.text = formattedDate.toString();
      });
    }
  }

  //  B O T T O M     S H E E T
  void bottom() {
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
  }

//   B U I L D
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
                        bottom();
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
                    customTextform('Name', nameController, Icon(Icons.person),
                        nameValidator),
                    Height10,
                    customTextform('Age', ageController,
                        Icon(Icons.cake_outlined), ageValidator),
                    Height10,
                    customTextform('Course', courseContoller,
                        Icon(Icons.event_note_sharp), courseValidator),
                    Height10,
                    TextFormField(
                      controller: dobContoller,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: ' Date of birth',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            selectDate(context);
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                      validator: dobValidator,
                    ),
                    Height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 210,
                          child: customTextform("Address", addressContoller,
                              Icon(Icons.home), placeValidator),
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
                              MaterialStateProperty.all(Colors.green),
                        ),
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
