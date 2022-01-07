//ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/login_model.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkProvider with ChangeNotifier {
  AuthStatus userStatus = AuthStatus.notLoggedIn;
  // AuthStatus registerStatus = AuthStatus.notRegistered;
  // var lan = AppLocalizations.of(context)!; //todo:
  String msg = "";
  String Rmsg = "";
  LoginModel? loginModel;
  LoginModel? registerModel;

  Future<void> userLogin(
      {required String email, required String password}) async {
    userStatus = AuthStatus.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromJson(value.data);

        if (value.data['status']) {
          userStatus = AuthStatus.loggedIn;
          if (loginModel!.user != null) {
            print("token : ${loginModel!.user!.token}");
            token = loginModel!.user!.token!;
            me = loginModel!.user;
          }
        } else {
          userStatus = AuthStatus.notLoggedIn;
        }
      } else {
        userStatus = AuthStatus.notLoggedIn;
        msg = value.data != null
            ? value.data['msg'].toString()
            : "Network error happend";
        print(msg);
      }
      notifyListeners();
    }).catchError((error) {
      userStatus = AuthStatus.notLoggedIn;
      print(error);
    });

    notifyListeners();
  }

  Future<void> userRegister(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    userStatus = AuthStatus.registering;
    notifyListeners();
    await DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "email": email,
      "password": password,
      "c_password": confirmPassword
    }).then((value) {
      print(userStatus);
      if (value.statusCode == 200) {
        userStatus = AuthStatus.registered;
        print(userStatus);
        registerModel = LoginModel.fromJson(value.data);
        if (registerModel!.user != null) {
          print(registerModel!.user!.token);
          token = registerModel!.user!.token;
          me = registerModel!.user;
        }
        notifyListeners();
      } else {
        userStatus = AuthStatus.notRegistered;
        print("${value.data}");
        Rmsg = value.data != null
            ? value.data['msg'].toString()
            : "Network error happend";
      }
      notifyListeners();
    });
  }

  Future<bool> userLogout() async {
    await DioHelper.getData(url: LOGOUT, token: token).then((value) {
      if (value.statusCode == 200) {
        userStatus = AuthStatus.loggedOut;
        return true;
      }
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
    return false;
  }
}
