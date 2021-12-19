class UserModel {
  int? id;
  String? name;
  String? image;
  String? bio;
  String? email;
  String? token;
  int? accountConfirmation;
  int? resetPassword;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    bio = json['bio'];
    email = json['email'];
    token = json['token'];
    accountConfirmation = json['account_confirmation'];
    resetPassword = json['reset_password'];
  }
}
