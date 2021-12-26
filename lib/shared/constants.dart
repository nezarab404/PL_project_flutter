import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? token;

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

List<String>? sortngOptions;

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

const sortngHeaders = [
  "remaining_days",
  "price",
  "name",
  "created_at",
  "expiration_date",
  "category",
  "quantity",
];

UserModel? me;
