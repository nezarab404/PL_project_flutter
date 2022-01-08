// ignore_for_file: prefer_typing_uninitialized_variables

class UserModel {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;
  String? bio;
  String? phone;
  String? facebook;
  var accountConfirmation;
  var resetPassword;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    bio = json['bio'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
    facebook = json['facebook'];
    accountConfirmation = json['account_confirmation'];
    resetPassword = json['reset_password'];
  }
}
