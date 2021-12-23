class DiscountsModel {
  double? mainPrice;
  List<Discount> discounts = [];

  DiscountsModel.fromJson(Map<String, dynamic> json) {
    mainPrice = json['main']*1.0;
    json['d'].forEach((element) {
      discounts.add(Discount.fromJson(element));
    });
  }
}

class Discount {
  int? remainingDays;
  double? percentage;

  Discount.fromJson(Map<String, dynamic> json) {
    remainingDays = json['remaining_days'];
    percentage = json['discount']*1.0;
  }
}
