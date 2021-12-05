import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainDarkBlue,
        elevation: 0.0,
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return Container(
          color: Colors.white,
        );
      },
      itemCount: 10,
      shrinkWrap: true,
      //physics: const NeverScrollableScrollPhysics(),
      // childAspectRatio: 1,
      // mainAxisSpacing: 10,
      // crossAxisSpacing: 10,
      // children: [
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      //   Container(
      //     color: Colors.white,
      //   ),
      // ],
    );
  }
}
