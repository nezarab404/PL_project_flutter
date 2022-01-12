// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/product_detailes_provider.dart';
import 'package:programming_languages_project/screens/profile_screen.dart';
import 'package:programming_languages_project/shared/commponents/comments_layout.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/end_points.dart';
import 'package:programming_languages_project/shared/network/dio_helper.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProductDetailesScreen extends StatelessWidget {
  ProductDetailesScreen({Key? key, required this.model}) : super(key: key) {
    DioHelper.getData(url: VIEW_PRODUCT + "/${model.id}", token: token)
        .then(print);
  }
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    var controller = CarouselController();
    var provider = Provider.of<ProductDetailesProvider>(context);
    var size = MediaQuery.of(context).size;
    var lan = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        await Provider.of<HomeProvider>(context, listen: false).getProducts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightDarkBlue,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "${model.name}",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => me!.id == model.userId
                        ? ProfileScreen.myProfile(
                            user: me,
                          )
                        : ProfileScreen(
                            user: model.user,
                          ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: model.user!.image != null
                      ? NetworkImage(model.user!.image!)
                      : const AssetImage("assets/images/avatar.png")
                          as ImageProvider,
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (model.userId != me!.id)
                SizedBox(
                  height: 60,
                  child: FloatingActionButton.extended(
                    backgroundColor: mainRed,
                    heroTag: "buy",
                    label: SizedBox(
                      width: size.width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(lan.buy,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.white, fontSize: 20)),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(Icons.add_shopping_cart, size: 28),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: size.width / 4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: mainGrey,
                                borderRadius: BorderRadius.circular(90)),
                            child: Text(
                              "${model.price!.roundToDouble()}\$",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: mainRed,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("Contact with seller"), //todo
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Uri url = Uri(
                                            scheme: 'tel',
                                            path: model.user!.phone);
                                        launch(url.toString());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Make a call"),
                                          LineIcon.phone()
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Uri url = Uri(
                                            scheme: 'mailto',
                                            path: model.user!.email,
                                            query: <String, String>{
                                              'subject': 'i want to buy'
                                            }
                                                .entries
                                                .map((e) =>
                                                    '${Uri.encodeComponent(e.key)} = ${Uri.encodeComponent(e.value)}')
                                                .join('&'));
                                        launch(url.toString());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Send an email"),
                                          LineIcon.envelope()
                                        ],
                                      ),
                                    ),
                                    if (model.user!.facebook != null)
                                      TextButton(
                                        onPressed: () {
                                          launch(model.user!.facebook!);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Go to facebook page"),
                                            LineIcon.facebook()
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ));
                    },
                  ),
                ),
              FloatingActionButton(
                backgroundColor: mainRed,
                onPressed: () {
                  Provider.of<ProductDetailesProvider>(context, listen: false)
                      .getComments(model.id!);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => Wrap(
                      children: [
                        CommentsLayout(
                          productId: model.id!,
                        )
                      ],
                    ),
                  );
                },
                heroTag: "comment",
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.comment),
                    Text(model.comments.toString())
                  ],
                ),
              ),
              FloatingActionButton(
                backgroundColor: mainRed,
                onPressed: model.userId != me!.id
                    ? () {
                        context
                            .read<ProductDetailesProvider>()
                            .like(model.id!, context);
                      }
                    : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      model.isLike! ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: Colors.white,
                    ),
                    Text("${model.likes}")
                  ],
                ),
                heroTag: "like",
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: lightDarkBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CarouselSlider(
                      carouselController: controller,
                      items: List.generate(
                        model.images.length,
                        (index) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.gif",
                            image: model.images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll:
                              model.images.length == 1 ? false : true,
                          height: 200,
                          viewportFraction: 0.8,
                          reverse: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          onPageChanged: (index, _) {
                            provider.changeCarouselIndex(index);
                          }),
                    ),
                    AnimatedSmoothIndicator(
                        activeIndex: provider.carouselIndex,
                        count: model.images.length,
                        effect: CustomizableEffect(
                          dotDecoration: DotDecoration(
                            color: Colors.white,
                            height: 15,
                            width: 3,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          activeDotDecoration: DotDecoration(
                            color: red,
                            height: 25,
                            width: 7,
                            borderRadius: BorderRadius.circular(90),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(LineIcons.folder),
                              // const Text("📂", style: TextStyle(fontSize: 30)),
                              Text("${model.category}",
                                  style: const TextStyle(fontSize: 14))
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(LineIcons.clock),
                              // const Text("⏳", style: TextStyle(fontSize: 30)),
                              Text("${model.remainingDays} ${lan.days}")
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(LineIcons.hashtag),
                              // const Text(
                              //   "#",
                              //   style: TextStyle(
                              //     fontSize: 30,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text("${model.quantity}")
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(LineIcons.eye),
                              Text("${model.views}")
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: size.height / 2.5 - 95,
                      child: SingleChildScrollView(
                        child: Text(
                          "${lan.description}: ${model.description}",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
