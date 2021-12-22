import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/screens/product_detailes_screen.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.model}) : super(key: key);
  ProductItem.tile({Key? key, required this.model}) : super(key: key) {
    _isTile = true;
  }
  ProductModel model;
  bool _isTile = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isTile
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: mainGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(model.images[0], fit: BoxFit.fill),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "${model.name}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "${model.category}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey[800]),
                                ),
                              ],
                            ),
                            Text(
                              "${model.price}\$",
                              style: TextStyle(color: mainRed),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: mainRed,
                          ),
                          height: double.infinity,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(text: "${model.remainingDays}"),
                            const TextSpan(
                              text: " Days",
                              style: TextStyle(
                                fontSize: 9,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ])),
                        ),
                        FloatingActionButton(
                          mini: true,
                          backgroundColor: mainRed,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailesScreen(model: model)));
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                          heroTag: "like",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductDetailesScreen(model: model)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: size.width / 2 - 15,
                height: size.width / 2 - 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffd3d3d3),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/loading.gif",
                              image: model.images[0],
                              fit: BoxFit.fill,
                              height: double.infinity,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: model.user!.image != null
                                        ? NetworkImage(model.user!.image!)
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: red.withOpacity(0.7),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${model.remainingDays}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model.name}",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                "${model.category}",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          Text("${model.price!.roundToDouble()}\$",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: mainRed, fontSize: 20))
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
  }
}
