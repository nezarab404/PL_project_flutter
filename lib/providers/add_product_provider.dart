import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

class AddProductProvider with ChangeNotifier {
  void uploadImage() async {
    final picker = ImagePicker();
    var file = await picker.pickImage(source: ImageSource.gallery);
    DioHelper.uploadFile(url: "", file: file!);
  }
}
