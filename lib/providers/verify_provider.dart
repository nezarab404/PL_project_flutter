import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

enum Status{
  notVerified,
  verified,
  verifying
}

class VerifyProvider with ChangeNotifier {
String msg = "";

  Future<void> registerVerify({required String code}) async {
    DioHelper.postData(url: VERIFY_REGISTER,token: token, data: {
      "code" : code
    }).then((value) {
      if (value.statusCode == 200){
          print(value.data);
      }
      else{
        print(value.data);
        msg = value.data['msg'];
      }
    });
  }
}
