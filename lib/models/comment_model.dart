import 'user_model.dart';

class CommentModel {
  var edit;
  int? productId;
  String? comment;
  String? time;
  UserModel? user;

  CommentModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    comment = json['text'];
    time = json['time'];
    edit = json['edit'];
    user = UserModel.fromJson(json['user']);
  }
}
