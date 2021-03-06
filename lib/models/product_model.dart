import 'package:programming_languages_project/models/user_model.dart';

import 'descount_model.dart';

class ProductModel {
  int? id;
  String? name;
  int? userId;
  List<String> images = [];
  String? description;
  String? category;
  String? expirationDate;
  int? remainingDays;
  double? quantity;
  double? price;
  UserModel? user;
  int? views;
  int? likes;
  int? comments;
  bool? isLike;
  DiscountsModel? priceInfo;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    json['images'].forEach((e) => images.add(e));
    description = json['description'];
    category = json['category'];
    expirationDate = json['expiration_date'];
    remainingDays = json['remaining_days'];
    quantity = json['quantity'] * 1.0;
    price = json['price'] * 1.0;
    user = UserModel.fromJson(json['user']);
    views = json['views_count'];
    likes = json['likes_count'];
    comments = json['comments_count'];
    isLike = json['me_likes'];
    if(json['discounts'] != null){
    priceInfo = DiscountsModel.fromJson(json['discounts']);}
  }
}
