// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/providers/theme_provider.dart';
import 'package:programming_languages_project/screens/landing_page.dart';
import 'package:programming_languages_project/screens/my_products_screen.dart';
import 'package:programming_languages_project/screens/products_i_like_screen.dart';
import 'package:programming_languages_project/screens/profile_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    var provider = Provider.of<HomeProvider>(context);
    var noListenProvider = Provider.of<HomeProvider>(context, listen: false);
    setCategories(context);
    setSortingOptions(context);
    setSearchOptions(context);
    setAppBarTitles(context);
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      isRtl: Localizations.localeOf(context) == const Locale('ar'),
      borderRadius: 40.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: theme.canvasColor,
      slideWidth: 250,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeInOut,
      mainScreen: const LandingPage(),
      menuScreen: Directionality(
        textDirection: Localizations.localeOf(context) == const Locale('ar')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: theme.splashColor,
          width: double.infinity,
          alignment: Localizations.localeOf(context) == const Locale('ar')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen.myProfile(
                        user: me,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    theme == darkTheme
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: me!.image != null
                                ? NetworkImage(me!.image!)
                                : const AssetImage(
                                    'assets/images/avatar.png',
                                  ) as ImageProvider,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: const Color(0xffDC1A45),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: theme.splashColor,
                              backgroundImage: me!.image != null
                                  ? NetworkImage(me!.image!)
                                  : const AssetImage(
                                      'assets/images/avatar.png',
                                    ) as ImageProvider,
                            ),
                          ),
                    Text(
                      me!.name!.split(" ").first,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: theme.textTheme.bodyText1!.color,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProductsILikeScreen()));
                      },
                      icon: Icon(
                        LineIcons.heart,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(
                        lan.productsILiked,
                        style: TextStyle(
                          color: theme.textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyProductsScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        LineIcons.shoppingBasket,
                        color: theme.iconTheme.color,
                      ),
                      label: Text(
                        lan.myProducts,
                        style: TextStyle(
                          color: theme.textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(
                        LineIcons.language,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        noListenProvider.changeLang(
                            !provider.language, context);
                      },
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Localizations.localeOf(context) ==
                                  const Locale('ar')
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          width: double.infinity,
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: theme.textTheme.bodyText1!.color),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lan.language),
                                Row(
                                  children: [
                                    Text(lan.arabic),
                                    Switch(
                                      value: provider.language,
                                      //activeTrackColor: Colors.grey,
                                      inactiveThumbColor: mainRed,
                                      activeColor: mainRed,
                                      inactiveTrackColor: mainRed!.shade900,
                                      onChanged: (val) => noListenProvider
                                          .changeLang(val, context),
                                    ),
                                    Text(lan.english),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(
                        LineIcons.penFancy,
                        color: theme.iconTheme.color,
                      ),
                      onPressed: () {
                        noListenProvider.changeLang(
                            !provider.language, context);
                      },
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Localizations.localeOf(context) ==
                                  const Locale('ar')
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          width: double.infinity,
                          child: DefaultTextStyle(
                            style: TextStyle(
                                color: theme.textTheme.bodyText1!.color),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(lan.themeType),
                                Row(
                                  children: [
                                    Text(lan.dark),
                                    Switch(
                                      value: Provider.of<ThemeChanger>(context)
                                          .themeBool,
                                      inactiveThumbColor: mainRed,
                                      activeColor: mainRed,
                                      inactiveTrackColor: mainRed!.shade900,
                                      onChanged: (val) =>
                                          Provider.of<ThemeChanger>(context,
                                                  listen: false)
                                              .setTheme(context, val),
                                    ),
                                    Text(lan.light),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Builder(
                builder: (ctx) => OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: theme.textTheme.bodyText1!.color!,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<NetworkProvider>(context, listen: false)
                          .userLogout()
                          .then((value) {
                        print('////////koko/////////// $value');

                        if (value) {
                          SharedHelper.removeData(key: TOKEN).then((value) {
                            print('////////momo/////////// $value');
                            if (value) {
                              Navigator.pushReplacement(
                                ctx,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            }
                          });
                        }
                      });
                    },
                    child: Text(
                      lan.logout,
                      style: TextStyle(
                        color: theme.textTheme.bodyText1!.color,
                        fontSize: 25,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
