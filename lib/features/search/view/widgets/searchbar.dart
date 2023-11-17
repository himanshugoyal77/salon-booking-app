import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/features/search/controller/searchbar_controller.dart';
import 'package:salon_app/utils/ui/styles.dart';

class MySearchBar extends StatefulWidget {
  MySearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    final searchQuery = TextEditingController();
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Find your best artist',
                hintStyle: Styles.body,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                    gapPadding: 0),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: Styles.primaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                fillColor: Styles.textGray,
                filled: true,
                alignLabelWithHint: true,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {},
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              context.read<SearchbarController>().changeFilter();
              print('filter');
            },
            child: Container(
              height: 38,
              width: 40,
              decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                CupertinoIcons.slider_horizontal_3,
                size: 20,
                color: Styles.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
