import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/screens/search_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    var provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainDarkBlue,
        elevation: 0.0,
        title: Text(
          provider.appBarTitles[provider.bottomNavBarIndex],
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: provider.screens[provider.bottomNavBarIndex],
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
          Provider.of<HomeProvider>(context, listen: false).changeIndex(index);
          // if (index == 2) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (_) => NewProductScreen()));
          // }
        },
      ),
    );
  }
}
