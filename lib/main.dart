import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/screens/home_screen.dart';
import 'package:programming_languages_project/screens/login_screen.dart';
import 'package:programming_languages_project/screens/new_product_screen.dart';
import 'package:programming_languages_project/screens/verification_code_screen.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'providers/add_product_provider.dart';
import 'providers/home_provider.dart';
import 'providers/product_detailes_provider.dart';
import 'providers/verify_provider.dart';
import 'shared/end_points.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedHelper.init();
  Widget widget = LoginScreen();
  UserModel? me;
  token = SharedHelper.getData(key: TOKEN);

  if (token != null) {
    await DioHelper.getData(url: ME, token: token).then((value) {
      me = UserModel.fromJson(value.data['user']);
    });
    if (me!.accountConfirmation == 1) {
      widget = HomeScreen();
    } else {
      widget = VerificationCodeScreen();
    }
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(mainWidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.mainWidget}) : super(key: key);
  final Widget mainWidget;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkProvider>(
          create: (_) => NetworkProvider(),
        ),
        ChangeNotifierProvider<ProductDetailesProvider>(
          create: (_) => ProductDetailesProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider()..getProducts(),
        ),
        ChangeNotifierProvider<AddProductProvider>(
          create: (_) => AddProductProvider(),
        ),
        ChangeNotifierProvider<VerifyProvider>(
          create: (_) => VerifyProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primarySwatch: mainRed,
        ),
        darkTheme: ThemeData(
          primarySwatch: mainRed,
          backgroundColor: mainDarkBlue,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          scaffoldBackgroundColor: mainDarkBlue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        home: ZoomDrawer(
          style: DrawerStyle.Style1,
          mainScreen: HomeScreen(),
          menuScreen: Container(
            padding: const EdgeInsets.all(10),
            color: darkBlue2,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                    ),
                    Text("Name",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white, fontSize: 24)),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.dangerous,
                          color: Colors.white,
                        ),
                        label: const Text("My Products",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                  ],
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
                            Navigator.pushReplacement(
                                ctx,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          }
                        });
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
        ),
      ),
    );
  }
}
