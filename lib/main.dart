import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_languages_project/providers/my_products_provider.dart';
import 'package:programming_languages_project/providers/network_provider.dart';
import 'package:programming_languages_project/providers/profile_provider.dart';
import 'package:programming_languages_project/providers/search_provider.dart';
import 'package:programming_languages_project/screens/login_screen.dart';
import 'package:programming_languages_project/screens/optional_user_info_screen.dart';
import 'package:programming_languages_project/screens/verification_code_screen.dart';
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
      child: MaterialApp(
        title: 'Dream Shop',
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
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
        home: mainWidget,
      ),
    );
  }
}
