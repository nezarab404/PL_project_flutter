import 'package:flutter/material.dart';
import 'package:programming_languages_project/providers/products_i_like_provider.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';
import 'package:provider/provider.dart';

class ProductsILikeScreen extends StatelessWidget {
  const ProductsILikeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductILikeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Products I Liked"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return 
               ProductItem.tile(model: provider.products[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: provider.products.length),
      ),
    );
  }
}
