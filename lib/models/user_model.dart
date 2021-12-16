class UserModel{
  int? id;
  String? name;
  String? image;
  String? bio;
  String? email;
  String? token;
  // ignore: prefer_typing_uninitialized_variables
  var accountConfirmation;

  UserModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    bio = json['bio'];
    email = json['email'];
    token = json['token'];
    accountConfirmation = json['account_confirmation'];
  }
}