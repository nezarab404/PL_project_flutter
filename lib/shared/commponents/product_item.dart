import 'package:flutter/material.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/screens/product_detailes_screen.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProductItem extends StatelessWidget {
   ProductItem({ Key? key ,required this.model}) : super(key: key);
  ProductModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ProductDetailesScreen(model: model,)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 200,
          height: 200,
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
                      child: Container(
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(model.images[0]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                             CircleAvatar(
                              backgroundImage: NetworkImage(model.user!.image!),
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