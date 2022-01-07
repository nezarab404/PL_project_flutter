// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';
import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/my_products_provider.dart';
import 'package:programming_languages_project/providers/new_product_provider.dart';
import 'package:programming_languages_project/screens/drawer.dart';
import 'package:programming_languages_project/shared/commponents/discounts_input_field.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/commponents/mbs_element.dart';
import 'package:programming_languages_project/shared/commponents/text_divider.dart';
import 'package:programming_languages_project/shared/constants.dart';

import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NewProductScreen extends StatefulWidget {
  bool isEdit = false;
  ProductModel? model;
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
  var formKey = GlobalKey<FormState>();

  NewProductScreen({Key? key}) : super(key: key);
  NewProductScreen.edit({Key? key, required this.model}) : super(key: key) {
    isEdit = true;
    price = TextEditingController(text: isEdit ? model!.price.toString() : "");
    quantity =
        TextEditingController(text: isEdit ? model!.quantity.toString() : "");
    name = TextEditingController(text: isEdit ? model!.name : "");
    description = TextEditingController(text: isEdit ? model!.description : "");
    rDays1 = TextEditingController(
        text: isEdit
            ? model!.priceInfo!.discounts[0].remainingDays.toString()
            : "");
    rDays2 = TextEditingController(
        text: isEdit
            ? model!.priceInfo!.discounts[1].remainingDays.toString()
            : "");
    rDays3 = TextEditingController(
        text: isEdit
            ? model!.priceInfo!.discounts[2].remainingDays.toString()
            : "");
    per1 = TextEditingController(
        text:
            isEdit ? model!.priceInfo!.discounts[0].percentage.toString() : "");
    per2 = TextEditingController(
        text:
            isEdit ? model!.priceInfo!.discounts[1].percentage.toString() : "");
    per3 = TextEditingController(
        text:
            isEdit ? model!.priceInfo!.discounts[2].percentage.toString() : "");
    number = TextEditingController(text: isEdit ? model!.phone : "");
    facebook = TextEditingController(text: isEdit ? model!.facebook : "");
  }

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<NewProductProvider>(context);
    var lan = AppLocalizations.of(context)!;
    if (widget.isEdit) {
      provider.setCategory(widget.model!.category!);
    }
    return Scaffold(
      //screen appbar
      // appBar: AppBar(
      //   backgroundColor: darkBlue2,
      //   centerTitle: true,
      //   title: Text(
      //     lan.addYourProduct,
      //   ),
      // ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenHeight / 30,
              ),
              //decoration divider
              TextDivider(
                text: lan.productSpecifications,
              ),
              SizedBox(
                height: screenHeight / 100,
              ),
              //row containing add image + 3 fields
              SizedBox(
                width: double.infinity,
                child: Row(
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SmallInputField(
                              label: lan.initialPrice,
                              icon: Icons.attach_money_outlined,
                              controller: widget.price),
                          SmallInputField(
                              label: lan.quantity,
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
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      lan.selectCategory,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: mainRed,
                                  ),
                                  items: categories!.map((cat) {
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
                                  onChanged: (val) =>
                                      provider.setCategory(val!)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 40,
              ),
              //add name
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.productName,
                pIcon: Icons.label,
                controller: widget.name,
              ),
              SizedBox(
                height: screenHeight / 40,
              ),

              //TODO
              // InputForm(
              //   screenWidth: screenWidth,
              //   hintText2: 'Expiration date',
              //   pIcon: Icons.date_range,
              //   controller: widget.date,
              //   inputType: TextInputType.none,
              //   isDate: true,
              //   dateFunction: () {
              //     provider.pickDate(context);

              //   },
              // ),

              //add description
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.description,
                pIcon: Icons.description,
                isDescription: true,
                controller: widget.description,
              ),

              // add date
              if (!widget.isEdit)
                SizedBox(
                  height: screenHeight / 40,
                ),
              if (!widget.isEdit)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth / 10,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.utc(2023),
                        ).then((value) {
                          if (value == null) {
                            return;
                          }
                          widget.date.text = DateFormat.yMMMd().format(value);
                          provider.date = value;
                        });
                      },
                      keyboardType: TextInputType.none,
                      showCursor: false,
                      controller: widget.date,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        border: InputBorder.none,
                        labelText: 'Expiration date',
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: screenHeight / 30,
              ),
              TextDivider(text: lan.discounts),
              SizedBox(
                height: screenHeight / 100,
              ),

              //discounts form
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        lan.remainingDays,
                        style: const TextStyle(
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
              TextDivider(
                text: lan.sellerContactInfo,
              ),
              SizedBox(
                height: screenHeight / 100,
              ),

              //phone num
              InputForm(
                screenWidth: screenWidth,
                hintText: lan.phoneNumber,
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
                hintText: lan.facebooko,
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
                      widget.isEdit
                          ? Provider.of<NewProductProvider>(context,
                                  listen: false)
                              .updateMyProduct(
                              productId: widget.model!.id!,
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
                              Provider.of<MyProductsProvider>(context,
                                      listen: false)
                                  .getMyProducts();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyDrawer()));
                            })
                          : print("momo ${widget.quantity.text}");
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
                        Provider.of<MyProductsProvider>(context, listen: false)
                            .getMyProducts();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MyDrawer()));
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
                height: screenHeight / 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAddImagesSheet(
  BuildContext context,
  double screenHeight,
  NewProductProvider provider,
) {
  var lan = AppLocalizations.of(context)!;
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: darkBlue,
    context: context,
    builder: (context) {
      return SizedBox(
        height: screenHeight / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              lan.pickImageForm,
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
                  text: lan.camera,
                  onPressed: () {
                    Navigator.of(context).pop();
                    provider.pickImage();
                  },
                ),
                MBSElement(
                  icon: Icons.photo_library,
                  text: lan.gallery,
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
}
