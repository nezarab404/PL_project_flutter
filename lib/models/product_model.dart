import 'package:programming_languages_project/models/user_model.dart';

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
  String? phone;
  String? facebook;
  double? price;
  UserModel? user;

  ProductModel.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     name = json['name'];
     userId = json['user_id'];
     json['images'].forEach((e) => images.add(e));
     description = json['description'];
     category = json['category'];
     expirationDate = json['expiration_date'];
     remainingDays = json['remaining_days'];
     quantity = json['quantity']*1.0;
     phone = json['phone'];
     facebook = json['facebook'];
     price = json['price'];
     user = UserModel.fromJson(json['user']);
  }
}
