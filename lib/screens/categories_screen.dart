import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/shared/commponents/my_grid_view.dart';
import 'package:programming_languages_project/shared/commponents/my_radio_buttons.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    var lan = AppLocalizations.of(context)!;
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
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                              width: 250,
                              height: 250,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/empty_cart.svg",
                              ),
                            ),
                            Text(
                              lan.noProductsFound,
                              style: TextStyle(
                                color: theme.textTheme.bodyText1!.color,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
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
