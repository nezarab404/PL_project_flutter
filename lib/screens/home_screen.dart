import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/shared/commponents/my_grid_view.dart';
import 'package:programming_languages_project/shared/commponents/my_radio_buttons.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    var size = MediaQuery.of(context).size;
    var lan = AppLocalizations.of(context)!;
    return GestureDetector(
      onHorizontalDragStart: (details) {
        ZoomDrawer.of(context)!.toggle();
      },
     // child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: mainDarkBlue,
        //   elevation: 0.0,
        //   title: Text(
        //     lan.home,
        //     style: Theme.of(context)
        //         .textTheme
        //         .headline5!
        //         .copyWith(color: Colors.white, fontSize: 28),
        //   ),
        //   leading: IconButton(
        //       onPressed: () => ZoomDrawer.of(context)!.toggle(),
        //       icon: const Icon(Icons.menu)),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (_) => SearchScreen()));
        //       },
        //       icon: const Icon(Icons.search),
        //     ),
        //   ],
        // ),

       // body:
        
        child: provider.getProductsStatus == Status.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return provider.getProducts();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .changeSort();
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.sort_rounded,
                                  size: 16,
                                ),
                                Text(lan.sortBy,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                Icon(
                                  provider.desc
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          MyRadioButtons(
                            titles: sortngOptions!,
                            headers: sortngHeaders,
                            width: size.width - 110,
                            height: 40,
                            onTap: (title) {
                              provider.getProducts(title: title);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyGridView(
                        itemCount: provider.products.length,
                        items: provider.products,
                      ),
                      const SizedBox(
                        height: 75,
                      )
                    ],
                  ),
                ),
              ),
        // extendBody: true,
        // bottomNavigationBar: DotNavigationBar(
        //   currentIndex: provider.bottomNavBarIndex,
        //   unselectedItemColor: mainDarkBlue,
        //   backgroundColor: const Color(0xffd3d3d3).withOpacity(0.8),
        //   margin: EdgeInsets.zero,
        //   borderRadius: 90,
        //   items: [
        //     DotNavigationBarItem(icon: const Icon(Icons.home)),
        //     DotNavigationBarItem(icon: const Icon(Icons.category)),
        //     DotNavigationBarItem(icon: const Icon(Icons.add)),
        //     DotNavigationBarItem(icon: const Icon(Icons.shopping_bag)),
        //   ],
        //   onTap: (index) {
        //     Provider.of<HomeProvider>(context, listen: false)
        //         .changeIndex(index);
        //     if (index == 2) {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (_) => NewProductScreen()));
        //     }
        //   },
        // ),
      );
    //);
  }
}
