import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';

import 'package:programming_languages_project/shared/themes/main_theme.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  static const _categories = [
    'Food',
    'Medicines',
    'Cosmetics',
    'Chemicals',
    'Detergents',
    'Other',
  ];

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  String? value;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue2,
        centerTitle: true,
        title: const Text(
          "Add Your Product",
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: screenHeight / 40,
            ),
            TextDivider('Product specifications'),
            SizedBox(
              height: screenHeight / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      color: darkBlue2,
                    ),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmallInputField(
                        'Initial price',
                        Icons.attach_money_outlined,
                      ),
                      SmallInputField(
                        "Quantity",
                        Icons.production_quantity_limits,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: value,
                            isExpanded: true,

                            hint: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '-Select category-',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down_circle,
                              color: mainRed,
                            ),
                            items: NewProductScreen._categories.map((cat) {
                              return DropdownMenuItem<String>(
                                value: cat,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    cat,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) => setState(() {
                              value = val;
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Product name',
              pIcon: Icons.label,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Expiration date',
              pIcon: Icons.date_range,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Description',
              pIcon: Icons.description,
              isDescription: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget TextDivider(String text) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Divider(
          thickness: 3,
          color: darkBlue2,
          indent: 40,
          endIndent: 40,
        ),
      ],
    );
  }
}

Widget SmallInputField(String label, IconData icon) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 6,
    child: TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: mainRed,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  );
}
