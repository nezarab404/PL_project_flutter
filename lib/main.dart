import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/providers/my_products_provider.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/providers/search_provider.dart';
import 'package:programming_languages_project/screens/login_screen.dart';
import 'package:programming_languages_project/screens/verification_code_screen.dart';
import 'package:programming_languages_project/shared/commponents/restart_widget.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/keys.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/storage/shared_helper.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';
import 'providers/new_product_provider.dart';
import 'providers/home_provider.dart';
import 'providers/product_detailes_provider.dart';
import 'providers/products_i_like_provider.dart';
import 'providers/verify_provider.dart';
import 'screens/drawer.dart';
import 'shared/end_points.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedHelper.init();
  Widget widget = LoginScreen();

  token = SharedHelper.getData(key: TOKEN);

  SharedHelper.saveData(key: 'lang', value: 'en');

  if (token != null) {
    await DioHelper.getData(url: ME, token: token).then((value) {
      if (value.statusCode == 200) {
        me = UserModel.fromJson(value.data['user']);
      } else {
        widget = LoginScreen();
      }
    }).catchError((error) {
      // ignore: avoid_print
      print(error);
    });
    if (me != null) {
      if (me!.accountConfirmation == 1) {
        widget = const MyDrawer();
      } else {
        widget = VerificationCodeScreen();
      }
    }
  } else {
    widget = LoginScreen();
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(RestartWidget(child: MyApp(mainWidget: widget)));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.mainWidget}) : super(key: key);
  final Widget mainWidget;
  bool? language;

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
          create: (_) => HomeProvider()
            ..getProducts()
            ..getCategoryProducts(),
        ),
        ChangeNotifierProvider<NewProductProvider>(
          create: (_) => NewProductProvider(),
        ),
        ChangeNotifierProvider<VerifyProvider>(
          create: (_) => VerifyProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider()..getProfile(),
        ),
        ChangeNotifierProvider<ProductILikeProvider>(
          create: (_) => ProductILikeProvider()..getLikedProducts(),
        ),
        ChangeNotifierProvider<MyProductsProvider>(
          create: (_) => MyProductsProvider()..getMyProducts(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
      ],
      child: MainMaterialApp(mainWidget: mainWidget),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({
    Key? key,
    required this.mainWidget,
  }) : super(key: key);

  final Widget mainWidget;

  @override
  Widget build(BuildContext context) {
    print(lang);
    return MaterialApp(
      title: 'Dream Shop',
      debugShowCheckedModeBanner: false,
      locale:
          // Locale(lang!)
          Provider.of<HomeProvider>(context).language
              ? const Locale('en')
              : const Locale('ar')
      // lang != null ? Locale(lang!) : null
      ,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: mainRed,
      ),
      darkTheme: ThemeData(
        primarySwatch: mainRed,
        backgroundColor: mainDarkBlue,
        fontFamily: "Baloo2",
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
      home: AnimatedSplashScreen(
        nextScreen: mainWidget,
        splash: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/cart_red2.png',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Dream Shop',
                  style: TextStyle(
                    color: mainRed,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        splashIconSize: 300,
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: lightDarkBlue,
      ),
    );
  }
}
