import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/student_management/reusablewidgets/button.dart';
import 'package:firebase/student_management/reusablewidgets/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatefulWidget {
  Map<dynamic, dynamic> docId;
  UpdateScreen({required this.docId, super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  File? file;
  String? imageURL;
  late Reference imagetoUploadRef;

  Future getImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedFile!.path);
    });

    uploadFile();
    return;
  }

  Future uploadFile() async {
    if (file != null) {
      DateTime.now().millisecondsSinceEpoch.toString();

      String url = widget.docId['image'];
      imagetoUploadRef = FirebaseStorage.instance.refFromURL(url);

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
    //print(widget.docId['name']);
    //print(widget.docId['rollnumber']);
    final nameController = TextEditingController(text: widget.docId['name']);
    final rnoController =
        TextEditingController(text: widget.docId['rollnumber']);
    GlobalKey<FormState> key = GlobalKey();
    //
    DocumentReference reference = FirebaseFirestore.instance
        .collection('student_management')
        .doc(widget.docId['id']);

    //

    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('update'),
        actions: [
          IconButton(
            onPressed: () {
              reference.delete();

              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Height30,
                InkWell(
                  onTap: getImage,
                  child: Container(
                    child: (widget.docId.containsKey('image') && file == null)
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage('${widget.docId['image']}'),
                            backgroundColor: Colors.white,
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(file!),
                          ),
                  ),
                ),
                Height30,
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item name';
                    }

                    return null;
                  },
                ),
                Height30,
                TextFormField(
                  controller: rnoController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item quantity';
                    }

                    return null;
                  },
                ),
                Height30,
                Button(
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        String name = nameController.text;
                        String rno = rnoController.text;

                        //Create the Map of data
                        Map<String, String> dataToUpdate = {
                          'name': name,
                          'rollnumber': rno,
                          'image': imageURL.toString(),
                        };

                        //Call update()
                        reference.update(dataToUpdate);
                        Navigator.pop(context);
                      }
                    },
                    title: 'Submit'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
