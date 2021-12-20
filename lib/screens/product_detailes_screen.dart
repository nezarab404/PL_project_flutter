import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/product_detailes_provider.dart';
import 'package:programming_languages_project/shared/commponents/comments_layout.dart';
import 'package:programming_languages_project/shared/commponents/profile_layout.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailesScreen extends StatelessWidget {
  ProductDetailesScreen({Key? key, required this.model}) : super(key: key);
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    var controller = CarouselController();
    var provider = Provider.of<ProductDetailesProvider>(context);
    var size = MediaQuery.of(context).size;

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileLayout()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: model.user!.image != null
                      ? NetworkImage(model.user!.image!)
                      : null,
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
                            Text("Buy",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.white, fontSize: 24)),
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: mainRed,
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              FloatingActionButton(
                backgroundColor: mainRed,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) =>
                        Wrap(children: const [CommentsLayout()]),
                  );
                },
                heroTag: "comment",
                child: const Icon(Icons.comment),
              ),
              FloatingActionButton(
                backgroundColor: mainRed,
                onPressed: () {
                  context
                      .read<ProductDetailesProvider>()
                      .like(model.id!, context);
                },
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
                              )),
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
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
                              const Text("📂", style: TextStyle(fontSize: 30)),
                              Text(
                                "${model.category}",
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Text("⏳", style: TextStyle(fontSize: 30)),
                              Text("${model.remainingDays} days")
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "#",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Text("${model.quantity}")
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
                          "${model.description}",
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

//  Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Column(
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.comment),
//                             ),
//                             Text(
//                               "99",
//                               style: Theme.of(context).textTheme.bodyText1,
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.thumb_up),
//                             ),
//                             Text(
//                               "99",
//                               style: Theme.of(context).textTheme.bodyText1,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
