import 'package:flutter/material.dart';
import 'package:programming_languages_project/screens/product_detailes_screen.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ProductDetailesScreen()));
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
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/image.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            const CircleAvatar(),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                color: red.withOpacity(0.7),
                                alignment: Alignment.center,
                                child: Text(
                                  "10",
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
                          "Strawberry",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "category",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    Text("500\$",
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