// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:file_picker/file_picker.dart';

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
      lastDate: DateTime.utc(2023),
    ).then((value) {
      if (value == null) {
        print("koko   $value");
        return;
      }
      date = value;
      print(date);
      print(DateFormat.yMMMd().format(value));
      notifyListeners();
      print(date);
    });
  }

  Future pickMultiImage() async {
    if (Platform.isLinux) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        var imagesList = result.paths.map((path) => File(path!)).toList();
        List<File>? tempImages = [];
        for (var image in imagesList) {
          tempImages.add(File(image.path));
        }
        images!.addAll(tempImages);
        notifyListeners();
      } else {
        // User canceled the picker
      }
    } else {
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

  Future<bool> addProduct({
    required double price,
    required double quantity,
    required String name,
    required String description,
    required int rDays1,
    required int rDays2,
    required int rDays3,
    required double discount1,
    required double discount2,
    required double discount3,
    //required int date,
  }) async {
    addProductStatus = Status.loading;
    print(addProductStatus);
    print("koko $quantity");
    FormData imageList = FormData.fromMap({
      "name": name,
      "description": description,
      "category": category,
      "quantity": quantity,
      "price": price,
      "expiration_date": date!,
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
    print(token);
    await DioHelper.postData(url: PRODUCTS, token: token, data: imageList)
        .then((value) {
      if (value.statusCode == 200) {
        addProductStatus = Status.success;
        print(addProductStatus);
        return true;
      } else {
        addProductStatus = Status.failed;
        print(addProductStatus);
        print(value);
        return false;
      }
    }).catchError((e) {
      print(e);
    });
    return false;
  }

  Future<bool> updateMyProduct({
    required int productId,
    required double price,
    required double quantity,
    required String name,
    required String description,
    required int rDays1,
    required int rDays2,
    required int rDays3,
    required double discount1,
    required double discount2,
    required double discount3,
    //required int date,
  }) async {
    addProductStatus = Status.loading;
    print(addProductStatus);
    print("koko $quantity");
    FormData imageList = FormData.fromMap({
      "name": name,
      "description": description,
      "category": category,
      "quantity": quantity,
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
      imageList.files.add(
        MapEntry(
          "image${i + 1}",
          await MultipartFile.fromFile(images![i].path,
              filename: images![i].path.split('/').last),
        ),
      );
    }

    await DioHelper.postData(
            url: PRODUCTS + '/$productId', token: token, data: imageList)
        .then((value) {
      if (value.statusCode == 200) {
        addProductStatus = Status.success;
        print(addProductStatus);
        return true;
      } else {
        addProductStatus = Status.failed;
        print(addProductStatus);
        //print(value.data['msg']);
        return false;
      }
    });
    return false;
  }
}
