import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/pages/home_page.dart';
import 'package:salon_app/utils/styles.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
    this.query,
    required this.isFilter,
  }) : super(key: key);

  final String? query;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    print('SearchPage: $isFilter');
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SearchFilter(
              query: query,
              isFilter: isFilter,
              path: "search",
            )
          ],
        ),
      ),
    );
  }
}
