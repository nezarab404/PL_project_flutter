import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:programming_languages_project/providers/search_provider.dart';
import 'package:programming_languages_project/shared/commponents/input_form.dart';
import 'package:programming_languages_project/shared/commponents/product_item.dart';
import 'package:programming_languages_project/shared/constants.dart';
import 'package:programming_languages_project/shared/status.dart';
import 'package:programming_languages_project/shared/themes/main_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();
  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    var provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainDarkBlue,
        title: Text(lan.search),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (provider.searchStatus == Status.loading)
              const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: provider.searchBy == lan.byName
                            ? InputForm(
                                controller: search,
                                hintText: lan.search,
                                pIcon: Icons.search,
                                onChanged: (val) {
                                  if (provider.searchBy == lan.byName) {
                                    provider.searchByName(val);
                                  }
                                })
                            : Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 6,
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
                                        date.text =
                                            DateFormat.yMMMd().format(value);
                                        provider.searchByDate(value);
                                      });
                                    },
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    controller: date,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.date_range),
                                      border: InputBorder.none,
                                      labelText: lan.expirationDate,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 6,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(15),
                                value: provider.searchBy,
                                isExpanded: true,
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    lan.byName, 
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: mainRed,
                                ),
                                items: searchBy!.map((cat) {
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  getBody(provider, context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBody(SearchProvider provider, BuildContext context) {
    var lan = AppLocalizations.of(context)!;
    if (provider.result.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 190,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ProductItem.tile(
              model: provider.result[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          itemCount: provider.result.length,
        ),
      );
    } else {
      return Center(
        child: Text(lan.noProductsFound,
            style:const TextStyle(color: Colors.white)),
      );
    }
  }
}
