import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

enum Status { notVerified, verified, verifying }

class VerifyProvider with ChangeNotifier {
  String msg = "";

  Future<bool> registerVerify({required String code}) async {
    bool verify=false;
    print("code : $code");
   await DioHelper.postData(url: VERIFY_REGISTER, token: token, data: {"code": code})
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        verify=true;
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
}
