import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/pages/artist_details_page.dart';
import 'package:salon_app/pages/search_page.dart';
import 'package:salon_app/utils/data.dart';
import 'package:salon_app/utils/styles.dart';
import 'package:salon_app/utils/text.dart';

const List<Map<String, String>> servicesList = [
  {
    "title": 'Manicures',
    "image": 'assets/services/s1.png',
  },
  {
    "title": 'Waxing',
    "image": 'assets/services/s2.png',
  },
  {
    "title": 'Facial',
    "image": 'assets/services/s3.png',
  },
  {
    "title": 'Haircut',
    "image": 'assets/services/s4.png',
  },
  {
    "title": 'Manicures',
    "image": 'assets/services/s1.png',
  },
  {
    "title": 'Waxing',
    "image": 'assets/services/s2.png',
  },
  {
    "title": 'Facial',
    "image": 'assets/services/s3.png',
  },
  {
    "title": 'Haircut',
    "image": 'assets/services/s4.png',
  }
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  double opacityVal = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          CupertinoIcons.list_bullet_indent,
          color: Styles.primaryColor,
        ),
        title: Text('Hi There', style: Styles.heading),
        actions: [
          CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundColor: Styles.textGray,
              radius: Styles.avatarRadius,
              child: Image.asset('assets/user-image.png')),
          const SizedBox(
            width: 18,
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification t) {
          if (t.metrics.axisDirection == AxisDirection.down) {
            setState(() {
              opacityVal = t.metrics.pixels;
            });
          }

          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                  opacity: (1 - opacityVal.clamp(0, 1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchFilter(),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 137, 129, 129)
                          .withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Services', style: Styles.heading),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                              children: servicesList
                                  .map((e) => ServiceCard(
                                      title: e["title"].toString(),
                                      image: e["image"].toString()))
                                  .toList()),
                        )),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Top Artist', style: Styles.heading),
                        Text('View all', style: Styles.body),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 205,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: DataLists.hairArtists
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        height: 200,
                                        width: (size.width / 2) - 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 137, 129, 129)
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  width: (size.width / 2) - 30,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            e["image"]
                                                                .toString()),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 7,
                                                  top: 7,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Styles.secondaryColor,
                                                    maxRadius: 12,
                                                    child: const Icon(
                                                        Icons.bookmark_outline,
                                                        size: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 4, top: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        e["name"].toString(),
                                                        style: AppTextStyles
                                                            .bodyExtraSmallMedium,
                                                      ),
                                                      const Spacer(),
                                                      const Icon(
                                                        Icons.star_rounded,
                                                        size: 18,
                                                        color: Colors.amber,
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        e["rating"].toString(),
                                                        style: Styles.body
                                                            .copyWith(
                                                                fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    e["profession"].toString(),
                                                    style: Styles.body.copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          '\$ ${e["per_hour_cost"].toString()}.00',
                                                          style: Styles.heading
                                                              .copyWith(
                                                            fontSize: 14,
                                                          )),
                                                      const Spacer(),
                                                      const Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '04',
                                                        style: Styles.body
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Top Artist Near You', style: Styles.heading),
                        Text('View all', style: Styles.body),
                      ],
                    ),
                    // make it scrollable
                    TopArtistCard(size: size),
                    // TopArtistCard(size: size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopArtistCard extends StatelessWidget {
  const TopArtistCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onPanUpdate: (details) {
      //   print(details.delta.dy);
      //   if (details.delta.dy < -0.6) {
      //     // naviagte to next screen
      //     Navigator.push(
      //         context,
      //         PageRouteBuilder(
      //             transitionDuration: const Duration(milliseconds: 800),
      //             reverseTransitionDuration: const Duration(milliseconds: 800),
      //             pageBuilder: (context, animation, animation2) {
      //               final CurvedAnimation curve = CurvedAnimation(
      //                   parent: animation, curve: const Interval(0, 0.5));
      //               return FadeTransition(
      //                 opacity: curve,
      //                 child: ArtistDetailsPage(
      //                   animation: curve,
      //                 ),
      //               );
      //             }));
      //   }
      //  },
      onTap: (() => Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              reverseTransitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (context, animation, animation2) {
                final CurvedAnimation curve = CurvedAnimation(
                    parent: animation, curve: const Interval(0, 0.5));
                return FadeTransition(
                  opacity: curve,
                  child: ArtistDetailsPage(
                    animation: curve,
                  ),
                );
              }))),
      child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(2),
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 137, 129, 129).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Hero(
                tag: 'assets/artists/a1.png',
                child: Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/artists/a1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: size.width - 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          '4.5',
                          style: Styles.body.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          '2.5 km',
                          style: Styles.body.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Hero(
                      tag: 'assets/artists/a1.png' + 'profession',
                      child: Text(
                        'Haircut Artist',
                        style: Styles.heading.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 137, 129, 129).withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Styles.body.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

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
    print('SearchFilter: ${widget.isFilter}');
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
                                  isFilter: widget.isFilter,
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
                                isFilter: widget.isFilter,
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

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.list_bullet_indent,
              color: Styles.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Hi There',
              style: Styles.heading,
            ),
          ],
        ),
        CircleAvatar(
            foregroundColor: Colors.transparent,
            backgroundColor: Styles.textGray,
            radius: Styles.avatarRadius,
            child: Image.asset('assets/user-image.png'))
      ],
    );
  }
}
