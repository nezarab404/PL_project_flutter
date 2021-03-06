// ignore_for_file: avoid_print
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:programming_languages_project/models/product_model.dart';
import 'package:programming_languages_project/providers/home_provider.dart';
import 'package:programming_languages_project/providers/my_products_provider.dart';
import 'package:programming_languages_project/providers/new_product_provider.dart';
import 'package:programming_languages_project/screens/my_products_screen.dart';
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
  var date = TextEditingController();
  var formKey = GlobalKey<FormState>();

  NewProductScreen({Key? key}) : super(key: key);

  NewProductScreen.edit({Key? key, required this.model}) : super(key: key) {
    isEdit = true;
    price = TextEditingController(
        text: isEdit ? model!.priceInfo!.mainPrice.toString() : "");
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
    var noListenProvider = Provider.of<NewProductProvider>(context);
    var lan = AppLocalizations.of(context)!;
    if (widget.isEdit) {
      provider.setEditImages(widget.model!.images);

      noListenProvider.setCategory(widget.model!.category!);
    }
    return Scaffold(
      appBar: widget.isEdit ? AppBar() : null,
      //body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //decoration divider
            TextDivider(
              text: lan.productSpecifications,
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
                            color: theme == darkTheme ? darkBlue2 : mainGrey,
                          )
                        : Stack(
                            children: [
                              Container(
                                width: 186,
                                height: 167,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: theme == darkTheme
                                      ? Colors.white
                                      : mainGrey,
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
                                      widget.isEdit
                                          ? provider.editImages!.length
                                          : provider.images!.length,
                                      (f) => Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          widget.isEdit
                                              ? provider.editImages![f] is File
                                                  ? Image.file(
                                                      provider.images![f],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      provider.editImages![f],
                                                      fit: BoxFit.cover,
                                                    )
                                              : Image.file(
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
                                                widget.isEdit
                                                    ? noListenProvider
                                                        .deleteImage(
                                                            provider
                                                                .editImages!,
                                                            f)
                                                    : noListenProvider
                                                        .deleteImage(
                                                            provider.images!,
                                                            f);
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
                                  widget.isEdit,
                                ),
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: mainDarkBlue,
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
                            widget.isEdit,
                          ),
                          iconSize: 50,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: theme == darkTheme ? mainDarkBlue : mainRed,
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
                        label: lan.initialPrice,
                        icon: Icons.attach_money_outlined,
                        controller: widget.price,
                      ),
                      SmallInputField(
                        label: lan.quantity,
                        icon: Icons.production_quantity_limits,
                        controller: widget.quantity,
                      ),
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
              hintText: lan.productName,
              pIcon: Icons.label,
              controller: widget.name,
            ),
            SizedBox(
              height: screenHeight / 40,
            ),

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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range),
                      border: InputBorder.none,
                      labelText: lan.expirationDate,
                      contentPadding: const EdgeInsets.all(10),
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
                      style: TextStyle(
                        color: theme.textTheme.bodyText1!.color,
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
                    Text(
                      '%',
                      style: TextStyle(
                        color: theme.textTheme.bodyText1!.color,
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
                    print("kokokokokokookokoko ${widget.isEdit}");
                    widget.isEdit
                        ? Provider.of<NewProductProvider>(context,
                                listen: false)
                            .updateMyProduct(
                            productId: widget.model!.id!,
                            price: double.parse(widget.price.text.contains('.')
                                ? widget.price.text
                                : widget.price.text + ".0"),
                            quantity: double.parse(widget.quantity.text.isEmpty
                                ? "1.0"
                                : widget.quantity.text.contains('.')
                                    ? widget.quantity.text
                                    : widget.quantity.text + ".0"),
                            name: widget.name.text,
                            description: widget.description.text,
                            rDays1: int.parse(widget.rDays1.text),
                            rDays2: int.parse(widget.rDays2.text),
                            rDays3: int.parse(widget.rDays3.text),
                            discount1: double.parse(
                                widget.per1.text.contains('.')
                                    ? widget.per1.text
                                    : widget.per1.text + ".0"),
                            discount2: double.parse(
                                widget.per2.text.contains('.')
                                    ? widget.per2.text
                                    : widget.per2.text + ".0"),
                            discount3: double.parse(
                                widget.per3.text.contains('.')
                                    ? widget.per3.text
                                    : widget.per3.text + ".0"),
                          )
                            .then((value) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getProducts();
                            Provider.of<MyProductsProvider>(context,
                                    listen: false)
                                .getMyProducts();
                            print("?????????????? ???? ?????????? $value");

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyProductsScreen(),
                              ),
                            );
                          })
                        : Provider.of<NewProductProvider>(context,
                                listen: false)
                            .addProduct(
                            price: double.parse(widget.price.text.contains('.')
                                ? widget.price.text
                                : widget.price.text + ".0"),
                            quantity: double.parse(
                              widget.quantity.text.isEmpty
                                  ? "1.0"
                                  : widget.quantity.text.contains('.')
                                      ? widget.quantity.text
                                      : widget.quantity.text + ".0",
                            ),
                            name: widget.name.text,
                            description: widget.description.text,
                            rDays1: int.parse(widget.rDays1.text),
                            rDays2: int.parse(widget.rDays2.text),
                            rDays3: int.parse(widget.rDays3.text),
                            discount1: double.parse(
                                widget.per1.text.contains('.')
                                    ? widget.per1.text
                                    : widget.per1.text + ".0"),
                            discount2: double.parse(
                                widget.per2.text.contains('.')
                                    ? widget.per2.text
                                    : widget.per2.text + ".0"),
                            discount3: double.parse(
                                widget.per3.text.contains('.')
                                    ? widget.per3.text
                                    : widget.per3.text + ".0"),
                          )
                            .then((value) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getProducts();
                            Provider.of<MyProductsProvider>(context,
                                    listen: false)
                                .getMyProducts();
                            Provider.of<HomeProvider>(context, listen: false)
                                .changeIndex(0);
                            widget.price.clear();
                            widget.per1.clear();
                            widget.per2.clear();
                            widget.per3.clear();
                            widget.quantity.clear();
                            widget.rDays1.clear();
                            widget.rDays2.clear();
                            widget.rDays3.clear();
                            widget.name.clear();
                            widget.date.clear();
                            widget.description.clear();
                            provider.images = [];
                          }); //1640905200
                  },
                  backgroundColor: mainRed,
                  child: Icon(
                    Icons.check,
                    color: theme.backgroundColor,
                    size: 40,
                  ),
                  elevation: 6,
                );
              }),
            ),
            SizedBox(
              height: screenHeight / 5,
            ),
          ],
        ),
      ),
    );
  }
}

void showAddImagesSheet(BuildContext context, double screenHeight,
    NewProductProvider provider, bool isEdit) {
  var lan = AppLocalizations.of(context)!;
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    backgroundColor: theme == darkTheme ? mainDarkBlue : mainGrey,
    context: context,
    builder: (context) {
      return SizedBox(
        height: screenHeight / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              lan.pickImageForm,
              style: TextStyle(
                color: theme.canvasColor,
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
                    provider.pickImage(isEdit);
                  },
                ),
                MBSElement(
                  icon: Icons.photo_library,
                  text: lan.gallery,
                  onPressed: () {
                    Navigator.of(context).pop();
                    provider.pickMultiImage(isEdit);
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
