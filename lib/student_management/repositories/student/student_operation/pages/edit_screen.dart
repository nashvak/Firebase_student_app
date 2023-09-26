import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../services/student_services.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController courseContoller = TextEditingController();
  TextEditingController dobContoller = TextEditingController();
  TextEditingController addressContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? file;
  String? imageURL;
  late Reference imagetoUploadRef;
  String? imageurl;
  Future getImage(String image) async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedFile!.path);
    });

    if (file != null) {
      imagetoUploadRef = FirebaseStorage.instance.refFromURL(image);

      try {
        await imagetoUploadRef.putFile(file!);
        imageURL = await imagetoUploadRef.getDownloadURL();
      } catch (error) {
        //print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String id = args['id'];
    Map<String, dynamic> student = args['myMap'];

    nameController = TextEditingController(text: student['name']);
    ageController = TextEditingController(text: student['age']);
    courseContoller = TextEditingController(text: student['course']);
    dobContoller = TextEditingController(text: student['dateOfBirth']);
    addressContoller = TextEditingController(text: student['address']);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        String name = nameController.text;
                        String age = ageController.text;
                        String course = courseContoller.text;
                        String dob = dobContoller.text.toString();
                        String address = addressContoller.text;

                        // Provider.of<StudentProvider>(context, listen: false)
                        //     .update(st);

                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, 'student');
                        //   String id = args['name'];
                        if (file == null) {
                          Map<String, String> dataToUpdate = {
                            'imageUrl': student['imageUrl'],
                            'name': name,
                            'dateOfBirth': dob,
                            'course': course,
                            'age': age,
                            'address': address,
                          };
                          FirebaseFirestore.instance
                              .collection('student_management')
                              .doc(id)
                              .update(dataToUpdate);
                          Navigator.pop(context);
                        } else {
                          Map<String, String> dataToUpdate = {
                            'imageUrl': imageURL.toString(),
                            'name': name,
                            'dateOfBirth': dob,
                            'course': course,
                            'age': age,
                            'address': address,
                          };
                          FirebaseFirestore.instance
                              .collection('student_management')
                              .doc(id)
                              .update(dataToUpdate);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                  onTap: () {
                    getImage(student['imageUrl']);
                  },
                  child: (file == null)
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(student['imageUrl']))
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(
                            file!,
                          ),
                        )),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: ageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: courseContoller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: dobContoller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: addressContoller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter something";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<StudentProvider>(context, listen: false)
                      .deleteStudent(id);

                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: const Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
