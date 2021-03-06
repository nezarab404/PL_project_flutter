// ignore_for_file: prefer_typing_uninitialized_variables

import 'user_model.dart';

class CommentModel {
  var edit;
  int? commentId;
  String? comment;
  String? time;
  UserModel? user;

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['id'];
    comment = json['text'];
    time = json['time'];
    edit = json['edit'];
    user = UserModel.fromJson(json['user']);
  }
}
