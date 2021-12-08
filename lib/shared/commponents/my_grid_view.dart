import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';

class MyGridView extends StatelessWidget {
  MyGridView({Key? key, required this.itemCount}) : super(key: key);
  int itemCount;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              itemCount.isEven ? (itemCount ~/ 2) : (itemCount ~/ 2) + 1,
              (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 10),
                    child: ProductItem(),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  itemCount ~/ 2,
                  (index) => const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ProductItem(),
                      ))),
        )
      ],
    );
  }
}
