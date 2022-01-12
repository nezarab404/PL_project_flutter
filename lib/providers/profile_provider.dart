// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';

class ProfileProvider with ChangeNotifier {
  UserModel? user;
  File? profileImage;
  List<ProductModel> userProducts = [];
  Status? profileInfoStatus = Status.init;
  Status? profileGetStatus = Status.init;
  Status? passStatus = Status.init;

  //TODO link with database

  Future<void> getProfile() async {
    profileGetStatus = Status.loading;
    await DioHelper.getData(url: ME, token: token).then((value) {
      if (value.statusCode == 200) {
        user = UserModel.fromJson(value.data["user"]);
        me = UserModel.fromJson(value.data["user"]);
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
      if (image == null) {
        print(
            '////////////////////////////image null////////////////////////////');
        return;
      }
      final tempImage = File(image.path);
      profileImage = tempImage;
      print(
          '/////////////////////////////image ok////////////////////////////');
      notifyListeners();
    } on PlatformException catch (exception) {
      print(
          '////////////////////////////image exception////////////////////////////');
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
    required String? email,
    required File? image,
    String? bio,
    String? phone,
    String? facebook,
  }) async {
    print(name);
    print(email);
    print(image);
    print(bio);
    print(phone);
    print(facebook);

    if (image != null) profileImage = image;
    profileInfoStatus = Status.loading;
    print(profileInfoStatus);
    FormData info = FormData.fromMap({
      "name": name,
      "email": email,
      "bio": bio == '' ? null : bio,
      "phone": phone == '' ? null : phone,
      "facebook": facebook == '' ? null : facebook,
      "image": image == null
          ? null
          : image.path.contains("http://")
              ? null
              : await MultipartFile.fromFile(
                  profileImage!.path,
                  filename: profileImage!.path.split('/').last,
                ),
    });
    image = null;
    bool b = false;
    await DioHelper.postData(url: UPDATEUSER, token: token, data: info)
        .then((value) {
      print("koko ${value.data}");
      if (value.statusCode == 200) {
        profileInfoStatus = Status.success;
        DioHelper.getData(url: ME, token: token).then(
          (value) {
            if (value.statusCode == 200) {
              me = UserModel.fromJson(value.data['user']);
            }
          },
        );
        print(profileInfoStatus);
        b = true;
      } else {
        profileInfoStatus = Status.failed;
        print(profileInfoStatus);
        b = false;
      }
    });
    return b;
  }

  Future<bool> getUserProduct(int userID) async {
    userProducts = [];
    bool b = false;
    await DioHelper.getData(url: USER_PRODUCTS + "/$userID", token: token)
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        value.data['products'].forEach((e) {
          userProducts.add(ProductModel.fromJson(e));
          b = true;
        });
      } else {
        b = false;
      }
    });
    return b;
  }
}
