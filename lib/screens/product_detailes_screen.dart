import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:programming_languages_project/providers/product_detailes_provider.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailesScreen extends StatelessWidget {
  const ProductDetailesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = CarouselController();
    var provider = Provider.of<ProductDetailesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightDarkBlue,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Strawberry",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              child: FloatingActionButton.extended(
                backgroundColor: mainRed,
                heroTag: "buy",
                label: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Buy",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white, fontSize: 24)),
                      const Icon(Icons.add, size: 28),
                    ],
                  ),
                ),
                onPressed: () {},
              ),
            ),
            FloatingActionButton(
              backgroundColor: mainRed,
              onPressed: () {},
              heroTag: "comment",
              child: const Icon(Icons.comment),
            ),
            FloatingActionButton(
              backgroundColor: mainRed,
              onPressed: () {},
              child: const Icon(Icons.thumb_up),
              heroTag: "like",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: lightDarkBlue,
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: controller,
                    items: List.generate(
                        5,
                        (index) => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Image.asset(
                                  "assets/images/i${index + 1}.png"),
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
                      count: 5,
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
                          children: const [
                            Text("📂", style: TextStyle(fontSize: 30)),
                            Text(
                              "koko",
                            )
                          ],
                        ),
                        Column(
                          children: const [
                            Text("⏳", style: TextStyle(fontSize: 30)),
                            Text("55")
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              "#️",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text("10")
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Text(
                        "description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description ",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ],
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