import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';

// ignore: must_be_immutable
class MyGridView extends StatelessWidget {
  MyGridView({Key? key, required this.itemCount , required this.items}) : super(key: key);
  int itemCount;
  List<ProductModel> items;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:itemCount == 1 ? MainAxisAlignment.start: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              itemCount.isEven ? (itemCount ~/ 2) : (itemCount ~/ 2) + 1,
              (index) =>  Padding(
                    padding:const EdgeInsets.only(bottom: 10, right: 10),
                    child: ProductItem(
                      model: items[index*2],
                    ),
                  )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  itemCount ~/ 2,
                  (index) =>  Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ProductItem(model: items[(index*2)+1],),
                      ))),
        )
      ],
    );
  }


}
