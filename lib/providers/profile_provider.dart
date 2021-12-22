// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider with ChangeNotifier {
  File? profileImage;

  //TODO link with database

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final tempImage = File(image.path);

      profileImage = tempImage;
      notifyListeners();
    } on PlatformException catch (exception) {
      print(exception.message);
    }
  }
}
