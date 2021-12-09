//ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/login_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class NetworkProvider with ChangeNotifier {
  Status loggedInStatus = Status.notLoggedIn;

  String msg = "";
  LoginModel? loginModel;


  Future<void> userLogin(
      {required String email, required String password}) async {
    loggedInStatus = Status.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: "auth/login",
      data: {"email": email, "password": password},
    ).then((value) {
      if (value.statusCode == 200) {

        loginModel = LoginModel.fromJson(value.data);

        if (value.data['status']) {
          loggedInStatus = Status.loggedIn;
          if (loginModel!.user != null) {
            print("token : ${loginModel!.user!.token}");
            token = loginModel!.user!.token!;
          } else {}
        } else {
          loggedInStatus = Status.notLoggedIn;
        }
      } else {
        print(msg = value.data['msg']);

      }
      notifyListeners();
    }).catchError((error) {
      print(error);
    });

    notifyListeners();
  }
}
