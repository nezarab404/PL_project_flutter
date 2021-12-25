import 'package:flutter/material.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';

class MyRadioButtons extends StatefulWidget {
  MyRadioButtons(
      {Key? key,
      required this.titles,
      required this.width,
      required this.onTap,
      this.lastTitle,
      this.height})
      : super(key: key);
  final String? lastTitle;
  final double? width;
  final double? height;
  final List<String> titles;
  final void Function(String?) onTap;

  @override
  _MyRadioButtonsState createState() => _MyRadioButtonsState();
}

int x = 0;

class _MyRadioButtonsState extends State<MyRadioButtons> {
  final List<RadioButtonItemModel> models = [];

  @override
  void initState() {
    for (var i = 0; i < widget.titles.length; i++) {
      if (i == x) {
        models.add(RadioButtonItemModel(true, widget.titles[i]));
      } else {
        models.add(RadioButtonItemModel(false, widget.titles[i]));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 30,
      width: widget.width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              setState(() {
                for (var element in models) {
                  element.isSelected = false;
                }
                models[index].isSelected = true;
                x = index;
                widget.onTap(sortngHeaders[index]);
              });
            },
            child: RadioItem(model: models[index]),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            width: 15,
          );
        },
        itemCount: models.length,
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  const RadioItem({Key? key, required this.model}) : super(key: key);
  final RadioButtonItemModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: model.isSelected ? mainRed : mainGrey),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      child: Text(
        model.title,
        style: TextStyle(
            fontSize: 14, color: model.isSelected ? mainGrey : mainRed),
      ),
    );
  }
}

class RadioButtonItemModel {
  bool isSelected;
  String title;
  int? id;
  static int counter = 0;
  RadioButtonItemModel(this.isSelected, this.title) {
    id = counter;
    counter++;
  }
}
