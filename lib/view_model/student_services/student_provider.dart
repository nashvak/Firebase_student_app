import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view_model/image_provider/image_provider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/student_models.dart';

final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('student_management');

class FirebaseService {
  // C R E A T E   S T U D E N T
  Future<void> createUser(String imageUrl, String name, String dob,
      String course, String age, String address) async {
    await _collectionReference.doc().set({
      'imageUrl': imageUrl,
      'name': name,
      'dateOfBirth': dob,
      'course': course,
      'age': age,
      'address': address,
    });
  }

//  U P D A T E   S T U D E N T
  Future<void> updateUser(String imageUrl, String name, String dob,
      String course, String age, String address, String id) async {
    await _collectionReference.doc(id).update({
      'imageUrl': imageUrl,
      'name': name,
      'dateOfBirth': dob,
      'course': course,
      'age': age,
      'address': address,
    });
  }
}

//

//

//

//

//

class StudentProvider with ChangeNotifier {
  ImageService imageService = ImageService();
  late Reference imagetoUploadRef;
  final FirebaseService firebaseService = FirebaseService();
  late String imageURL;

  //  C R E A T E    S T U D E N T
  Future<void> createStudent(Student st) async {
    String imageUrl = await imageService.uploadImage(st.dp);

    await firebaseService.createUser(
        imageUrl, st.name, st.dob, st.course, st.age, st.address);
    notifyListeners();
  }

  /// D E L E T E   S T U D E N T
  Future<void> deleteStudent(String docId) async {
    await _collectionReference.doc(docId).delete();
    notifyListeners();
  }

  //  E D I T   I M A G E

  Future<String?> editProfileImage(File? file, String imageUrl) async {
    imagetoUploadRef = FirebaseStorage.instance.refFromURL(imageUrl);

    try {
      await imagetoUploadRef.putFile(file!);
      imageURL = await imagetoUploadRef.getDownloadURL();
      return imageURL;
    } catch (error) {
      //print(error);
      return "Error";
    }
  }

//   U P D A T E   S T U D E N T
  Future<void> updateStudent(Student st, String id) async {
    await firebaseService.updateUser(
        st.dp, st.name, st.dob, st.course, st.age, st.address, id);
    notifyListeners();
  }

  //  S E L E C T  D A T E  O F   B I R T H
  String? date;
  Future<String> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2024),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      date = formattedDate.toString();
      notifyListeners();
    }
    return date!;
  }
}
