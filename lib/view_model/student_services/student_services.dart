import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/student_models.dart';

final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('student_management');

class FirebaseService {
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
class StudentProvider with ChangeNotifier {
  late Reference imagetoUploadRef;
  final FirebaseService _firebaseService = FirebaseService();
  late String imageURL;

  Future<String> uploadImage(var imageFile) async {
    if (imageFile != null) {
      String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference imagetoUploadRef =
          FirebaseStorage.instance.ref().child('images').child(uniqueFilename);

      await imagetoUploadRef.putFile(imageFile!);
      String imageURL = await imagetoUploadRef.getDownloadURL();
      return imageURL;
      // } catch (error) {
      //   print(error);
      // }
    } else {
      return "Error";
    }
  }

  /// C R E A T E    F U N C T I O N
  Future<void> createUser(Student st) async {
    String imageUrl = await uploadImage(st.dp);

    await _firebaseService.createUser(
        imageUrl, st.name, st.dob, st.course, st.age, st.address);
    notifyListeners();
  }

  /// D E L E T E   F U N C T I O N
  Future<void> deleteStudent(String docId) async {
    await _collectionReference.doc(docId).delete();
    notifyListeners();
  }

  //  E D I T   I M A G E

  Future<String?> editProfileImage(File? file, String imageUrl) async {
    // String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

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
  Future<void> update(Student st, String id) async {
    await _firebaseService.updateUser(
        st.dp, st.name, st.dob, st.course, st.age, st.address, id);
    notifyListeners();
  }
}
