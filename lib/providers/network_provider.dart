import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/login_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggenIn,
  regesterd,
  authenticating,
  registering,
  loggedOut
}

class NetworkProvider with ChangeNotifier {
  Status loggedInStatus = Status.notLoggedIn;


  LoginModel? loginModel;


  Future<void> userLogin(
      {required String email,
        required String password}) async {
    loggedInStatus = Status.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: 'auth/login',
      data: {"email": email, "password": password},
    ).then((value) {
      print(value);
      print(loggedInStatus);
      loginModel = LoginModel.fromJson(value.data);
      print(value.data['status']);
      if (value.data['status']) {
        loggedInStatus = Status.loggenIn;
        if (loginModel!.user != null) {
          print("token : ${loginModel!.user!.token}");
          token = loginModel!.user!.token;  //token var is exist in shared/constants.dart
        }
      } else {
        loggedInStatus = Status.notLoggedIn;
      }

      notifyListeners();
    }).catchError((error) {
      print('the error is $error');
    });
    notifyListeners();
  }


}