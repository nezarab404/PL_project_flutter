import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
      children:[
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: const[
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
            ],
          ),
        ),
        Container(
           padding: EdgeInsets.all(8),
          child: Column(
            children: const[
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
            ],
          ),
        ),
      ]
    ));
  }
}
