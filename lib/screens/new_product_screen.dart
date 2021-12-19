import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/new_product_provider.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';

import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

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
  var price = TextEditingController();
  var quantity = TextEditingController();
  var name = TextEditingController();
  var description = TextEditingController();
  var rDays1 = TextEditingController();
  var rDays2 = TextEditingController();
  var rDays3 = TextEditingController();
  var per1 = TextEditingController();
  var per2 = TextEditingController();
  var per3 = TextEditingController();
  var number = TextEditingController();
  var facebook = TextEditingController();
  var date = TextEditingController();
  var key = GlobalKey<FormState>();

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) return;
  //     final tempImage = File(image.path);
  //     setState(() {
  //       images!.add(tempImage);
  //     });
  //   } on PlatformException catch (exception) {
  //     print(exception.message);
  //   }
  // }

  // Future pickMultiImage() async {
  //   try {
  //     final imagesList = await ImagePicker().pickMultiImage();
  //     if (imagesList!.isEmpty) return;
  //     List<File>? tempImages = [];
  //     for (var image in imagesList) {
  //       tempImages.add(File(image.path));
  //     }
  //
  //     setState(() {
  //       images = tempImages;
  //     });
  //   } on PlatformException catch (exception) {
  //     print(exception.message);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<NewProductProvider>(context);
    return Scaffold(
      //screen appbar
      appBar: AppBar(
        backgroundColor: darkBlue2,
        centerTitle: true,
        title: const Text(
          'Add Your Product',
        ),
      ),

      //body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: screenHeight / 30,
            ),
            //decoration divider
            TextDivider('Product specifications'),
            SizedBox(
              height: screenHeight / 100,
            ),
            //row containing add image + 3 fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    //add image
                    provider.images!.isEmpty
                        ? SvgPicture.asset(
                            'assets/images/image_placeholder.svg',
                            color: darkBlue2,
                          )
                        : Stack(
                            children: [
                              Container(
                                width: 186,
                                height: 167,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GridView(
                                    padding: const EdgeInsets.all(5),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 186 / 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    children: List.generate(
                                      provider.images!.length,
                                      (f) => Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.file(
                                            provider.images![f],
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: -7,
                                            bottom: -7,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              color: mainRed,
                                              onPressed: () {
                                                setState(() {
                                                  provider.images!.remove(
                                                      provider.images![f]);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: darkBlue,
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: screenHeight / 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Pick Image Form',
                                              style: TextStyle(
                                                color: mainGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                MBSElement(
                                                  icon: Icons.camera_alt,
                                                  text: 'Camera',
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    provider.pickImage();
                                                  },
                                                ),
                                                MBSElement(
                                                  icon: Icons.photo_library,
                                                  text: 'Gallery',
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    provider.pickMultiImage();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: darkBlue,
                                ),
                              ),
                            ],
                          ),
                    if (provider.images!.isEmpty)
                      Positioned(
                        top: 30,
                        left: 30,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: darkBlue,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: screenHeight / 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Pick Image Form',
                                        style: TextStyle(
                                          color: mainGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MBSElement(
                                            icon: Icons.camera_alt,
                                            text: 'Camera',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              provider.pickImage();
                                            },
                                          ),
                                          MBSElement(
                                            icon: Icons.photo_library,
                                            text: 'Gallery',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              provider.pickMultiImage();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          iconSize: 50,
                          icon: const Icon(
                            Icons.add_a_photo,
                          ),
                        ),
                      ),
                  ],
                ),
                //price, quantity and category fields
                SizedBox(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmallInputField(
                          label: 'Initial price',
                          icon: Icons.attach_money_outlined,
                          controller: price),
                      SmallInputField(
                          label: 'Quantity',
                          icon: Icons.production_quantity_limits,
                          controller: quantity),
                      //category
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: provider.category,
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
                              onChanged: (val) => provider.setCategory(val!)),
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
            //add name
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Product name',
              pIcon: Icons.label,
              controller: name,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            //add date
            // InputForm(
            //   screenWidth: screenWidth,
            //   hintText: 'Expiration date',
            //   pIcon: Icons.date_range,
            //   //TODO
            // ),
            ElevatedButton(
                onPressed: () {
                  provider.pickDate(context);
                },
                child: Text('Expiration date')),
            // Container(
            //   width: 370,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
            // ),
            SizedBox(
              height: screenHeight / 40,
            ),
            //add description
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Description',
              pIcon: Icons.description,
              isDescription: true,
              controller: description,
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            TextDivider('Discounts'),
            SizedBox(
              height: screenHeight / 100,
            ),

            //discounts form
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Remaining days',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 100,
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(controller: rDays1),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(controller: rDays2),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(controller: rDays3),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      '%',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 100,
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(
                          cardColor: mainRed, controller: per1),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(
                          cardColor: mainRed, controller: per2),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(
                          cardColor: mainRed, controller: per3),
                    ),
                  ],
                ),
              ],
            ),

            //user details
            SizedBox(
              height: screenHeight / 30,
            ),
            TextDivider('Seller contact info'),
            SizedBox(
              height: screenHeight / 100,
            ),

            //phone num
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Phone number',
              inputType: TextInputType.phone,
              pIcon: Icons.phone,
              controller: number,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),
            //facebook account
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Facebook account (Optional)',
              inputType: TextInputType.url,
              pIcon: Icons.facebook,
              controller: facebook,
            ),
            SizedBox(
              height: screenHeight / 30,
            ),

            //done button
            SizedBox(
              height: screenHeight / 10,
              width: screenHeight / 10,
              child: Builder(builder: (ctx) {
                return FloatingActionButton(
                  onPressed: () {
                    print("momo ${quantity.text}");
                    Provider.of<NewProductProvider>(context, listen: false)
                        .addProduct(
                      price: double.parse(price.text + ".0"),
                      quantity: double.parse(
                          quantity.text.isEmpty ? "1.0" : quantity.text + ".0"),
                      name: name.text,
                      description: description.text,
                      phone: number.text,
                      rDays1: int.parse(rDays1.text),
                      rDays2: int.parse(rDays2.text),
                      rDays3: int.parse(rDays3.text),
                      discount1: double.parse(per1.text + ".0"),
                      discount2: double.parse(per2.text + ".0"),
                      discount3: double.parse(per3.text + ".0"),

                      // price: 55.5,
                      // quantity: 10.0,
                      // name: "koko",
                      // description:
                      //     " description.text description.text description.text",
                      // phone: "0000",
                      // rDays1: 10,
                      // rDays2: 6,
                      // rDays3: 2,

                      // discount1: 70,
                      // discount2: 60,
                      // discount3: 40,
                      // date: DateTime(2021,12,20).millisecondsSinceEpoch,
                    )
                        .then((value) {
                      Provider.of<HomeProvider>(context, listen: false)
                          .getProducts();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => MyDrawer()));
                    }); //1640905200
                  },
                  backgroundColor: mainRed,
                  child: Icon(
                    Icons.check,
                    color: mainDarkBlue,
                    size: 40,
                  ),
                  elevation: 6,
                );
              }),
            ),
            SizedBox(
              height: screenHeight / 30,
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

class MBSElement extends StatelessWidget {
  IconData? icon;
  String? text;
  Function()? onPressed;

  MBSElement({required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 70,
          onPressed: onPressed,
          icon: Icon(
            icon,
          ),
        ),
        Text(
          text!,
          style: TextStyle(
            color: mainGrey,
          ),
        ),
      ],
    );
  }
}

Widget SmallInputField(
    {String? label, IconData? icon, TextEditingController? controller}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 6,
    child: TextFormField(
      controller: controller,
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

Widget DiscountsInputField(
    {Color? cardColor, TextEditingController? controller}) {
  return Card(
    color: cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 6,
    child: TextFormField(
      controller: controller,
      cursorColor: cardColor == mainRed ? Colors.white : mainRed,
      style: TextStyle(
        color: cardColor == mainRed ? Colors.white : Colors.black,
      ),
      textAlign: TextAlign.center,
      maxLength: 2,
      textInputAction: TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 5,
        ),
      ),
    ),
  );
}
