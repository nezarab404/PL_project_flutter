import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/screens/new_product_screen.dart';
import 'package:programming_languages_project/shared/commponents/my_grid_view.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return GestureDetector(
      onHorizontalDragStart: (details) {
        ZoomDrawer.of(context)!.toggle();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainDarkBlue,
          elevation: 0.0,
          title: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white, fontSize: 28),
          ),
          leading: IconButton(
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return provider.getProducts();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return buildCategoryItem();
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        width: 15,
                      );
                    },
                    itemCount: 10,
                  ),
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
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
          currentIndex: provider.bottomNavBarIndex,
          unselectedItemColor: mainDarkBlue,
          backgroundColor: const Color(0xffd3d3d3).withOpacity(0.8),
          margin: EdgeInsets.zero,
          borderRadius: 90,
          items: [
            DotNavigationBarItem(icon: const Icon(Icons.home)),
            DotNavigationBarItem(icon: const Icon(Icons.category)),
            DotNavigationBarItem(icon: const Icon(Icons.add)),
            DotNavigationBarItem(icon: const Icon(Icons.shopping_bag)),
          ],
          onTap: (index) {
            Provider.of<HomeProvider>(context, listen: false)
                .changeIndex(index);
            if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const NewProductScreen()));
            }
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: mainRed),
      width: 50,
      height: 25,
    );
  }
}
