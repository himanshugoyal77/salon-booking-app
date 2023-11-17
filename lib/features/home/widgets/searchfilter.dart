import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/features/search/view/pages/search_page.dart';
import 'package:salon_app/utils/ui/styles.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter({
    super.key,
    this.query,
    this.isFilter = false,
    this.path,
  });

  final String? query;
  bool isFilter;
  final String? path;

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
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
              controller: widget.query != null
                  ? TextEditingController(text: widget.query)
                  : searchQuery,
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
              onSubmitted: (value) {
                if (widget.path != 'search') {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 800),
                          pageBuilder: (context, animation, animation2) {
                            final CurvedAnimation curve = CurvedAnimation(
                                parent: animation,
                                curve: const Interval(0, 0.5));
                            return FadeTransition(
                                opacity: curve,
                                child: SearchPage(
                                  query: value,
                                ));
                          }));
                }
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.path == 'search') {
                print('isFilter: ${widget.isFilter} tapped');
                setState(() {
                  widget.isFilter = !widget.isFilter;
                });
              } else {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, animation2) {
                          final CurvedAnimation curve = CurvedAnimation(
                              parent: animation, curve: const Interval(0, 0.5));
                          return FadeTransition(
                              opacity: curve,
                              child: SearchPage(
                                query: widget.query,
                              ));
                        }));
              }
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
