// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/screens/cart_screen.dart';
import 'package:programming_languages_project/screens/categories_screen.dart';
import 'package:programming_languages_project/screens/home_screen.dart';
import 'package:programming_languages_project/screens/new_product_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeProvider with ChangeNotifier {
  int bottomNavBarIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    NewProductScreen(),
    const CartScreen()
  ];
  List<String> appBarTitles = [
    "Home",
    "Categories",
    "Add your product",
    "Cart"
  ];
  bool desc = true;
  List<ProductModel> products = [];
  List<ProductModel> categoryProducts = [];
  String? lastTitle;
  String? lastCategory;
  Status getProductsStatus = Status.init;
  Status getCategoryStatus = Status.init;

  void changeIndex(int index) {
    bottomNavBarIndex = index;
    notifyListeners();
  }

  void changeSort() {
    desc = !desc;
    getProducts(title: lastTitle);
    notifyListeners();
  }

  setAppBarTitles(BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    appBarTitles = [
      lan.home,
      lan.categories,
      lan.addYourProduct,
      lan.cart,
    ];
    notifyListeners();
  }

  Future<void> getProducts({String? title = "remaining_days"}) {
    products = [];
    lastTitle = title;
    getProductsStatus = Status.loading;

    print(getProductsStatus);
    return DioHelper.getData(
            url: PRODUCTS, token: token, sort: title, desc: desc)
        .then((value) {
      if (value.statusCode == 200) {
        value.data["products"].forEach((product) {
          products.add(ProductModel.fromJson(product));
        });
        getProductsStatus = Status.success;
        print(getProductsStatus);
      } else {
        getProductsStatus = Status.failed;
        print(getProductsStatus);
      }
      print(getProductsStatus);
      notifyListeners();
    }).catchError((error) {
      getProductsStatus = Status.failed;
      notifyListeners();
    });
  }

  Future<void> getCategoryProducts({String? category = "Food"}) async {
    categoryProducts = [];
    lastCategory = category;
    getCategoryStatus = Status.loading;
    return DioHelper.postData(
        url: CATEGORIES,
        token: token,
        data: {"category": category}).then((value) {
      if (value.statusCode == 200) {
        value.data["products"].forEach((product) {
          categoryProducts.add(ProductModel.fromJson(product));
        });
        getCategoryStatus = Status.success;
        print(getCategoryStatus);
      } else {
        getCategoryStatus = Status.failed;
        print(getCategoryStatus);
      }
      print(getCategoryStatus);
      notifyListeners();
    });
  }

  void addLike(int id) {
    int index = products.indexWhere((element) => element.id == id);
    if (!products[index].isLike!) {
      products[index].likes = products[index].likes! + 1;
      products[index].isLike = true;
    } else {
      products[index].likes = products[index].likes! - 1;
      products[index].isLike = false;
    }
    notifyListeners();
  }
}
