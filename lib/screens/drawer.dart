import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/screens/my_products_screen.dart';
import 'package:programming_languages_project/screens/products_i_like_screen.dart';
import 'package:programming_languages_project/screens/profile_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

import 'home_screen.dart';
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
    setCategories(context);
    setSortingOptions(context);
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      isRtl: true,
      mainScreen: const HomeScreen(),
      menuScreen: Container(
        padding: const EdgeInsets.all(10),
        color: darkBlue2,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen.myProfile(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        me!.image != null ? NetworkImage(me!.image!) : null,
                  ),
                  Text(me!.name!.split(" ").first,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white, fontSize: 24)),
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
                    icon: const Icon(
                      Icons.dangerous,
                      color: Colors.white,
                    ),
                    label:  Text(
                      lan.productsILiked,
                      style: const TextStyle(
                        color: Colors.white,
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
                    icon: const Icon(
                      Icons.my_library_add,
                      color: Colors.white,
                    ),
                    label:  Text(
                      lan.myProducts,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ), 
            Builder(
              builder: (ctx) => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8)),
                  onPressed: () {
                    //TODO : LOGOUT
                    SharedHelper.removeData(key: TOKEN).then((value) {
                      if (value) {
                        Navigator.pushReplacement(ctx,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      }
                    });
                  },
                  child:  Text(
                    lan.logout,
                    style:const TextStyle(color: Colors.white, fontSize: 25),
                  )),
            )
          ],
        ),
      ),
      borderRadius: 40.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: mainGrey,
      slideWidth: 200,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeInOut,
    );
  }
}
