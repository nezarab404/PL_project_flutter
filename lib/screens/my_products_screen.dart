import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/my_products_provider.dart';
import 'package:programming_languages_project/screens/home_screen.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyProductsScreen extends StatelessWidget {
  MyProductsScreen({Key? key}) : super(key: key);

  Key dissmissKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProductsProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<HomeProvider>(context, listen: false)
            .getProducts()
            .then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Products"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                    'Are you sure to delete this item?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Provider.of<MyProductsProvider>(context,
                                                listen: false)
                                            .deleteMyProduct(
                                                provider.products[index].id!);
                                      },
                                      child: const Text(
                                        'Confirm',
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),

                  child: ProductItem.tile(
                    model: provider.products[index],
                    isMyProduct: true,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: provider.products.length),
        ),
      ),
    );
  }
}
