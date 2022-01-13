import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

String? token;
String? lang = 'en';

List<String>? categories;

setCategories(BuildContext context) {
  var lan = AppLocalizations.of(context)!;
  categories = [
    lan.food,
    lan.medicines,
    lan.cosmetics,
    lan.chemicals,
    lan.detergents,
    lan.other,
  ];
}

List<String>? sortngOptions, searchBy;

setSortingOptions(BuildContext context) {
  var lan = AppLocalizations.of(context)!;
  sortngOptions = [
    lan.remainingDays,
    lan.price,
    lan.name,
    lan.creatingDate,
    lan.expirationDate,
    lan.category,
    lan.quantity,
  ];
}

setSearchOptions(BuildContext context) {
  var lan = AppLocalizations.of(context)!;
  searchBy = [lan.byName, lan.byDate];
}

List<String> appBarTitles = [];
setAppBarTitles(BuildContext context) {
  var lan = AppLocalizations.of(context)!;
  appBarTitles = [
    lan.home,
    lan.categories,
    lan.addYourProduct,
    lan.cart,
  ];
}

const sortngHeaders = [
  "remaining_days",
  "price",
  "name",
  "created_at",
  "expiration_date",
  "category",
  "quantity",
];

const categoriesHeadres = [
  "Food",
  "Medicines",
  "Cosmetics",
  "Chemicals",
  "Detergents",
  "Other",
];

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: mainRed,
  ),
  primarySwatch: mainRed,
  splashColor: Colors.white,
  canvasColor: const Color(0xffDC1A45),
  backgroundColor: Colors.white,
  fontFamily: "Baloo2",
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black),
);

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: mainDarkBlue,
  ),
  primarySwatch: mainRed,
  splashColor: darkBlue2,
  canvasColor: mainGrey,
  backgroundColor: mainDarkBlue,
  fontFamily: "Baloo2",
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: mainDarkBlue,
  iconTheme: const IconThemeData(color: Colors.white),
);

ThemeData theme = lightTheme;

UserModel? me;
