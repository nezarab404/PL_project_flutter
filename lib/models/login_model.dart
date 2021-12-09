import 'user_model.dart';

class LoginModel{
  bool? status;
  String? message;
  UserModel? user;

  LoginModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['msg'];
    user = UserModel.fromJson(json['user']);
  }
}

