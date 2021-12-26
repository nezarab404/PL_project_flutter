import 'package:programming_languages_project/models/user_model.dart';

String? token;

const categories = [
  'Food',
  'Medicines',
  'Cosmetics',
  'Chemicals',
  'Detergents',
  'Other',
];

const sortngOptions = [
  "Remaining Days",
  "Price",
  "Name",
  "Creating Date",
  "Expiration Date",
  "Category Name",
  "Quantity",
];
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
