//ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/login_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
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
  Status registerStatus = Status.notRegistered;

  String msg = "";
  String Rmsg = "";
  LoginModel? loginModel;
  LoginModel? registerModel;

  Future<void> userLogin(
      {required String email, required String password}) async {
    loggedInStatus = Status.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: LOGIN,
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
      }
      else {
        print(msg = value.data['msg']);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
    });

    notifyListeners();
  }

  Future<void> userRegister(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    registerStatus = Status.registering;
    notifyListeners();
   await DioHelper.postData(url: REGISTER, data: {
      "name" : name,
      "email" : email,
      "password" : password,
      "c_password" : confirmPassword
    }).then((value){
      print(registerStatus);
      if (value.statusCode == 200){
        registerStatus=Status.registered;
        print(registerStatus);
        registerModel = LoginModel.fromJson(value.data);
        if (registerModel!.user != null) {
          print(registerModel!.user!.token);
          token = registerModel!.user!.token;
        }
        notifyListeners();
      }
      else{
        registerStatus = Status.notRegistered;
        print(value.data['msg']);
        Rmsg = value.data['msg'].toString();
      }
      notifyListeners();
    });
  }
}
