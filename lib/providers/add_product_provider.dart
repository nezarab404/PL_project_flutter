import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

class AddProductProvider with ChangeNotifier {
  void uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    // var data = FormData.fromMap(
    //     {"file": await MultipartFile.fromFile(file.path, filename: fileName)});
    DioHelper.postData(url: "", data: {
      "file": await MultipartFile.fromFile(file.path, filename: fileName)
    });
  }
}
