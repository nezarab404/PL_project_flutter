import 'package:flutter/material.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/shared/commponents/my_grid_view.dart';
import 'package:programming_languages_project/shared/commponents/my_radio_buttons.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);

    var size = MediaQuery.of(context).size;
    return provider.getCategoryStatus == Status.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyRadioButtons(
                      titles: categories!,
                      headers: categoriesHeadres,
                      width: size.width - 30,
                      height: 40,
                      onTap: (category) {
                        provider.getCategoryProducts(category: category);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                provider.categoryProducts.isEmpty
                    ? const Center(
                        child: Text("No Products"),
                      )
                    : MyGridView(
                      itemCount: provider.categoryProducts.length,
                      items: provider.categoryProducts,
                    ),
                const SizedBox(
                  height: 75,
                )
              ],
            ),
          );
  }
}
