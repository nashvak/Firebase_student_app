import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService with ChangeNotifier {
  File? file;
  XFile? pickedFile;
  String? imageURL;

  // A C C E S S    I M A G E
  Future<File> getImag(bool isCamera) async {
    final picker = ImagePicker();
    if (isCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    file = File(pickedFile!.path);
    notifyListeners();
    return file!;
  }

  //  U P L O A D   I M A G E   T O   F I R E B A S E
  Future<String> uploadImage(var imageFile) async {
    if (imageFile != null) {
      String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference imagetoUploadRef =
          FirebaseStorage.instance.ref().child('images').child(uniqueFilename);
      await imagetoUploadRef.putFile(imageFile!);
      imageURL = await imagetoUploadRef.getDownloadURL();
      notifyListeners();
    }
    return imageURL!;
  }
}
