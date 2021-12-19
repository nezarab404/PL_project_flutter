import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';

enum Statuss { notVerified, verified, verifying }

class VerifyProvider with ChangeNotifier {
  String msg = "";
  UserModel? user;
  Status s = Status.init;

  Future<bool> registerVerify({required String code}) async {
    bool verify = false;
    print("code : $code");
    await DioHelper.postData(
        url: VERIFY_REGISTER, token: token, data: {"code": code}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        verify = true;
      } else {
        print(value.data);
        msg = value.data['msg'];
      }
    });
    notifyListeners();
    return verify;
  }

  Future<void> resendCode() {
    return DioHelper.getData(url: SEND_REGISTER_VERIFY_CODE, token: token)
        .then((value) {});
  }

  Future<void> resetVerify(
      {required String email, required String code}) async {
    s = Status.loading;
    notifyListeners();
    await DioHelper.postData(
        url: CHECK_PASSWORD_VERIVY_EMAIL,
        data: {"email": email, "code": code}).then((value) {
      if (value.statusCode == 200) {
        user = UserModel.fromJson(value.data['user']);
        token = user!.token;
        me = user;
        SharedHelper.saveData(key: TOKEN, value: token);
        s = Status.success;
        notifyListeners();
      } else {
        print("soso");
        s = Status.failed;
        notifyListeners();
      }
    }).catchError(( e) {
      s = Status.failed;

      print("koko");
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> resetPassword(
      {required String password, required String confirmPassword}) async {
    s = Status.loading;

    await DioHelper.postData(
            url: RESET_PASSWORD,
            token: token,
            data: {"password": password, "c_password": confirmPassword})
        .then((value) {
      if (value.statusCode == 200) {
        s = Status.success;
        notifyListeners();
      } else {
        s = Status.failed;
        print(value);
      }
      notifyListeners();
    }).catchError((e) {
      s = Status.failed;
    });
  }
}
