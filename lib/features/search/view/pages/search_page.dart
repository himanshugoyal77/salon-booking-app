import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/components/searchbar.dart';
import 'package:salon_app/features/home/controller/searchcontroller.dart';
import 'package:salon_app/features/search/controller/searchbar_controller.dart';

import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/features/home/widgets/topartist.dart';
import 'package:salon_app/features/search/view/widgets/searchbar.dart';
import 'package:salon_app/utils/data/data.dart';
import 'package:salon_app/utils/ui/styles.dart';

import '../../../../utils/ui/text.dart';
import "../../../../utils/data/data.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int isResultsFound = -1;
  int val = 4;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<SearchbarController>(context);
    print('isFilter: ${provider.isFilter} from top');
    return Scaffold(
      backgroundColor: Styles.secondaryColor,
      appBar: AppBar(
        backgroundColor: Styles.secondaryColor,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Styles.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySearchBar(),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: provider.isFilter,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 650),
                      child: Text(
                        "Services",
                        style: AppTextStyles.bodyRegularBold
                            .copyWith(fontSize: 16, color: Styles.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Visibility(
                    visible: provider.isFilter,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 650),
                      child: Wrap(
                        spacing: 6,
                        children: context
                            .watch<SearchQueryProvider>()
                            .options
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isResultsFound = -1;
                                    });
                                    context
                                        .read<SearchQueryProvider>()
                                        .setOption(e["id"]);
                                  },
                                  child: Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      side: BorderSide(
                                          color: Styles.primaryColor
                                              .withOpacity(0.7),
                                          width: 0.8),
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      backgroundColor: e["isSelected"]
                                          ? Styles.primaryColor
                                          : Colors.white,
                                      visualDensity:
                                          VisualDensity.adaptivePlatformDensity,
                                      label: Text(e["title"].toString(),
                                          style: e["isSelected"]
                                              ? AppTextStyles.bodyRegularBold
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          Styles.secondaryColor)
                                              : AppTextStyles.bodyRegularBold
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: Styles
                                                          .primaryColor))),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: provider.isFilter,
                      child: const SizedBox(height: 20)),
                  Visibility(
                    visible: provider.isFilter,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        "Rating",
                        style: AppTextStyles.bodyRegularBold
                            .copyWith(fontSize: 16, color: Styles.primaryColor),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: provider.isFilter,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 700),
                      child: Slider(
                        value: val.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            val = value.round();
                            isResultsFound = -1;
                          });
                          context
                              .read<SearchQueryProvider>()
                              .setRating(val.toDouble());
                        },
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: val.toString(),
                        activeColor: Styles.primaryColor,
                        inactiveColor: Styles.primaryColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height:
                  !provider.isFilter ? size.height * 0.78 : size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ...DataLists.hairArtists.where((element) {
                          String parsedElement = element.values
                              .toList()
                              .join(", ")
                              .toString()
                              .toLowerCase();
                          bool containsSerachQuery = parsedElement.contains(
                              context
                                  .read<SearchQueryProvider>()
                                  .query
                                  .toLowerCase());
                          bool containsServices = parsedElement.contains(context
                              .read<SearchQueryProvider>()
                              .servcies
                              .join(", ")
                              .toLowerCase());
                          bool containsRating =
                              double.parse(element['rating'].toString()) >=
                                  context.read<SearchQueryProvider>().rating;

                          return containsSerachQuery &&
                              containsServices &&
                              containsRating;
                        }).map((e) {
                          setState(() {
                            isResultsFound = 1;
                          });
                          return TopArtistCard(data: e);
                        }).toList(),
                        isResultsFound == -1
                            ? Center(
                                child: Text(
                                  "No results found",
                                  style: AppTextStyles.bodyRegularBold.copyWith(
                                      fontSize: 16, color: Styles.primaryColor),
                                ),
                              )
                            : const SizedBox(),
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
