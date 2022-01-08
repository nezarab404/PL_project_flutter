// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class ProfileProvider with ChangeNotifier {
  UserModel? user;
  File? profileImage;

  Status? profileInfoStatus = Status.init;
  Status? profileGetStatus = Status.init;
  Status? passStatus = Status.init;

  //TODO link with database

  Future<void> getProfile() async {
    profileGetStatus = Status.loading;
    await DioHelper.getData(url: ME, token: token).then((value) {
      if (value.statusCode == 200) {
        me = user = UserModel.fromJson(value.data["user"]);
        profileImage = File(user!.image!);
        notifyListeners();
        profileGetStatus = Status.success;
      } else {
        profileGetStatus = Status.failed;
      }
      notifyListeners();
    }).catchError((e) {
      profileGetStatus = Status.failed;
      notifyListeners();
    });
  }

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

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    passStatus = Status.loading;

    await DioHelper.postData(url: CHANGE_PASSWORD, token: token, data: {
      "old_password": oldPassword,
      "password": newPassword,
      "c_password": confirmPassword,
    }).then((value) {
      if (value.statusCode == 200) {
        passStatus = Status.success;
        notifyListeners();
      } else {
        passStatus = Status.failed;
        print(value);
      }
      notifyListeners();
    }).catchError((e) {
      passStatus = Status.failed;
    });
  }

  Future<bool> updateProfile({
    required String? name,
    required String? bio,
    required String? email,
    required File? image,
    String? phone,
    String? facebook,
  }) async {
    profileImage = image;
    profileInfoStatus = Status.loading;
    print(profileInfoStatus);
    FormData info = FormData.fromMap({
      "name": name,
      "bio": bio,
      "email": email,
      "phone": phone,
      "facebook": facebook,
      "image": await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      ),
    });

    await DioHelper.postData(url: UPDATEUSER, token: token, data: info)
        .then((value) {
      if (value.statusCode == 200) {
        profileInfoStatus = Status.success;
        print(profileInfoStatus);
        return true;
      } else {
        profileInfoStatus = Status.failed;
        print(profileInfoStatus);
        return false;
      }
    });
    return false;
  }
}
