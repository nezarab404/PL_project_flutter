import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/new_product_provider.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:programming_languages_project/shared/commponents/discounts_input_field.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:programming_languages_project/shared/commponents/text_divider.dart';

import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

class NewProductScreen extends StatefulWidget {
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
  NewProductScreen({Key? key}) : super(key: key);

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
            const TextDivider(
              text: 'Product specifications',
            ),
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
                                onPressed: () => showAddImagesSheet(
                                  context,
                                  screenHeight,
                                  provider,
                                ),
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
                          onPressed: () => showAddImagesSheet(
                            context,
                            screenHeight,
                            provider,
                          ),
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
                          controller: widget.price),
                      SmallInputField(
                          label: 'Quantity',
                          icon: Icons.production_quantity_limits,
                          controller: widget.quantity),
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
              controller: widget.name,
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
              child: const Text('Expiration date'),
            ),

            SizedBox(
              height: screenHeight / 40,
            ),
            //add description
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Description',
              pIcon: Icons.description,
              isDescription: true,
              controller: widget.description,
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            const TextDivider(text: 'Discounts'),
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
                      child: DiscountsInputField(controller: widget.rDays1),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(controller: widget.rDays2),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(controller: widget.rDays3),
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
                          cardColor: mainRed, controller: widget.per1),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(
                          cardColor: mainRed, controller: widget.per2),
                    ),
                    SizedBox(
                      width: screenWidth / 4,
                      child: DiscountsInputField(
                          cardColor: mainRed, controller: widget.per3),
                    ),
                  ],
                ),
              ],
            ),

            //user details
            SizedBox(
              height: screenHeight / 30,
            ),
            const TextDivider(
              text: 'Seller contact info',
            ),
            SizedBox(
              height: screenHeight / 100,
            ),

            //phone num
            InputForm(
              screenWidth: screenWidth,
              hintText: 'Phone number',
              inputType: TextInputType.phone,
              pIcon: Icons.phone,
              controller: widget.number,
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
              controller: widget.facebook,
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
                    print("momo ${widget.quantity.text}");
                    Provider.of<NewProductProvider>(context, listen: false)
                        .addProduct(
                      price: double.parse(widget.price.text + ".0"),
                      quantity: double.parse(
                        widget.quantity.text.isEmpty
                            ? "1.0"
                            : widget.quantity.text + ".0",
                      ),
                      name: widget.name.text,
                      description: widget.description.text,
                      phone: widget.number.text,
                      rDays1: int.parse(widget.rDays1.text),
                      rDays2: int.parse(widget.rDays2.text),
                      rDays3: int.parse(widget.rDays3.text),
                      discount1: double.parse(widget.per1.text + ".0"),
                      discount2: double.parse(widget.per2.text + ".0"),
                      discount3: double.parse(widget.per3.text + ".0"),
                    )
                        .then((value) {
                      Provider.of<HomeProvider>(context, listen: false)
                          .getProducts();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MyDrawer()));
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
}

void showAddImagesSheet(
  BuildContext context,
  double screenHeight,
  NewProductProvider provider,
) =>
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
