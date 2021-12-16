import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class NewProductProvider with ChangeNotifier {
  List<File>? images = [];
  String? category;
  DateTime? date;
  Status? addProductStatus = Status.init;
  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.utc(2022),
    ).then((value) {
      if (value == null) return;
      date = value;
      notifyListeners();
      print(date);
    });
  }

  void uploadImage() async {
    final picker = ImagePicker();
    var file = await picker.pickImage(source: ImageSource.gallery);
    DioHelper.uploadFile(url: "", file: file!);
  }

  Future pickMultiImage() async {
    try {
      final imagesList = await ImagePicker().pickMultiImage();
      if (imagesList!.isEmpty) return;
      List<File>? tempImages = [];
      for (var image in imagesList) {
        tempImages.add(File(image.path));
      }

      images!.addAll(tempImages);
      notifyListeners();
    } on PlatformException catch (exception) {
      print(exception.message);
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final tempImage = File(image.path);

      images!.add(tempImage);
      notifyListeners();
    } on PlatformException catch (exception) {
      print(exception.message);
    }
  }

  Future<void> addProduct({
    required double price,
    required double quantity,
    required String name,
    required String description,
    required String phone,
    required int rDays1,
    required int rDays2,
    required int rDays3,
    required double discount1,
    required double discount2,
    required double discount3,
    //required int date,
    String? facebook,
  }) async {
    addProductStatus = Status.loading;
    FormData imageList = FormData.fromMap({
      "name": name,
      "description": description,
      "category": category,
      "phone": phone,
      "price": price,
      "expiration_date": date!.millisecondsSinceEpoch,
      "discounts": jsonEncode(
        [
          {"remaining_days": rDays1, "discount": discount1},
          {"remaining_days": rDays2, "discount": discount2},
          {"remaining_days": rDays3, "discount": discount3},
        ],
      ),
      "image1": await MultipartFile.fromFile(images![0].path,
          filename: images![0].path.split('/').last)
    });
    for (var i = 1; i < images!.length; i++) {
      imageList.files.add(MapEntry(
          "image${i + 1}",
          await MultipartFile.fromFile(images![i].path,
              filename: images![i].path.split('/').last)));
    }

    DioHelper.postData(url: PRODUCTS, token: token, data: imageList)
        .then((value) {
      if (value.statusCode == 200) {
        addProductStatus = Status.success;
        print(addProductStatus);
      } else {
        addProductStatus = Status.failed;
        print(addProductStatus);
        print(value.data['msg']);
      }
    });
  }
}
