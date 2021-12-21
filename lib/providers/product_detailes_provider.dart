import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/comment_model.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';

class ProductDetailesProvider with ChangeNotifier {
  int carouselIndex = 0;
  ProductModel? product;
  List<CommentModel> comments = [];

  Status productStatus = Status.init;
  Status likeStatus = Status.init;
  Status commentStatus = Status.init;

  void changeCarouselIndex(int index) {
    carouselIndex = index;
    notifyListeners();
  }

  Future<void> like(int id, BuildContext context) async {
    likeStatus = Status.loading;

    notifyListeners();
    await DioHelper.getData(token: token, url: LIKE + "/$id").then((value) {
      if (value.statusCode == 200) {
        likeStatus = Status.success;
        getProduct(id, context);
        Provider.of<HomeProvider>(context, listen: false).addLike(id);
        notifyListeners();
        print(value);
      } else {
        print(value);
        likeStatus = Status.failed;
      }
      notifyListeners();
    }).catchError((e) {
      likeStatus = Status.failed;
      notifyListeners();
    });
  }

  Future<void> getProduct(int id, BuildContext context) async {
    productStatus = Status.loading;
    await DioHelper.getData(url: PRODUCTS + "/$id").then((value) {
      if (value.statusCode == 200) {
        product = ProductModel.fromJson(value.data);
        notifyListeners();
        productStatus = Status.success;
      } else {
        productStatus = Status.failed;
      }
      notifyListeners();
    }).catchError((e) {
      productStatus = Status.failed;
      notifyListeners();
    });
  }

  Future<void> getComments(int productId) async {
    comments = [];
    commentStatus = Status.loading;
    await DioHelper.getData(url: COMMENTS + "/$productId", token: token)
        .then((value) {
      if (value.statusCode == 200) {
        value.data['comments'].forEach((cmnt) {
          comments.add(CommentModel.fromJson(cmnt));
          notifyListeners();
        });
      } else {
        productStatus = Status.failed;
      }
      notifyListeners();
    }).catchError((e) {
      commentStatus = Status.failed;
      notifyListeners();
    });
  }
}
