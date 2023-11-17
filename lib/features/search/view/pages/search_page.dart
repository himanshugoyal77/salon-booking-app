import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/components/searchbar.dart';
import 'package:salon_app/features/search/controller/searchbar_controller.dart';

import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/features/home/widgets/topartist.dart';
import 'package:salon_app/utils/ui/styles.dart';

import '../../../../utils/ui/text.dart';

List<Map<String, dynamic>> options = [
  {
    "id": 0,
    "title": "Haircut",
    "isSelected": false,
  },
  {
    "id": 1,
    "title": "Hair Color",
    "isSelected": false,
  },
  {
    "id": 2,
    "title": "Makeup",
    "isSelected": false,
  },
  {
    "id": 3,
    "title": "Spa",
    "isSelected": false,
  },
  {
    "id": 4,
    "title": "Trim & Shave",
    "isSelected": false,
  }
];

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    this.query,
  }) : super(key: key);

  final String? query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MySearchBar(),
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
                        children: options
                            .map((e) => Chip(
                                side: BorderSide(
                                    color: Styles.primaryColor.withOpacity(0.7),
                                    width: 0.8),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                backgroundColor: Styles.secondaryColor,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                label: Text(e["title"].toString())))
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
                        value: 4,
                        onChanged: (value) {},
                        min: 1,
                        max: 5,
                        activeColor: Styles.primaryColor,
                        inactiveColor: Styles.primaryColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: !provider.isFilter ? size.height * 0.78 : size.height * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                    TopArtistCard(size: size),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
