import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/shared/commponents/my_grid_view.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';
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
        // drawer: ZoomDrawer(
        //   style: DrawerStyle.Style7,
        //   controller: _zoomDrawerController,
        //   menuScreen: HomeScreen(),
        //   mainScreen: Container(
        //     color: Colors.amber,
        //     width: 200,
        //   ),
        //   borderRadius: 24.0,
        //   // showShadow: true,
        //   // clipMainScreen: true,
        //   // openCurve: Curves.bounceIn,
        //   angle: -10.0,
        //   // backgroundColor: Colors.grey[300]!,
        //   slideWidth: 100,
        //   swipeOffset: 10,
        // ),
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
            DotNavigationBarItem(icon: const Icon(Icons.person)),
            DotNavigationBarItem(icon: const Icon(Icons.add)),
            DotNavigationBarItem(icon: const Icon(Icons.category)),
          ],
          onTap: (index) {
            Provider.of<HomeProvider>(context, listen: false)
                .changeIndex(index);
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverStaggeredGrid.extentBuilder(
          staggeredTileBuilder: (index) =>
              StaggeredTile.extent(1, (index + 100).toDouble()),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: 200,
          itemBuilder: (_, index) {
            return Container(
              color: Colors.white,
            );
          },
          itemCount: 10,
        ),
      ],
    );
  }

  // Widget buildBody2(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 40,
  //           child: ListView.separated(
  //             physics: const BouncingScrollPhysics(),
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (ctx, index) {
  //               return buildCategoryItem();
  //             },
  //             separatorBuilder: (ctx, index) {
  //               return const SizedBox(
  //                 width: 15,
  //               );
  //             },
  //             itemCount: 10,
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Expanded(
  //           child: StaggeredGridView.countBuilder(
  //             staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1),
  //             crossAxisSpacing: 10,
  //             mainAxisSpacing: 10,
  //             crossAxisCount: 2,
  //             physics: const BouncingScrollPhysics(),
  //             itemBuilder: (_, index) {
  //               return const ProductItem();
  //             },
  //             itemCount: 50,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildCategoryItem() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: mainRed),
      width: 50,
      height: 25,
    );
  }
}
