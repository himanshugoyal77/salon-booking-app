import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/db/userinfo.dart';
import 'package:salon_app/features/details/view/pages/artist_details_page.dart';
import 'package:salon_app/features/home/widgets/searchfilter.dart';
import 'package:salon_app/features/home/widgets/services.dart';
import 'package:salon_app/features/home/widgets/topartist.dart';
import 'package:salon_app/features/search/view/pages/search_page.dart';
import 'package:salon_app/utils/data/data.dart';
import 'package:salon_app/utils/services/notifications.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

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
  String? uid;

  @override
  void initState() {
    super.initState();
    UserDb.getUserInfo().then((value) {
      setState(() {
        uid = value!.uid;
      });
    });
  }

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
                                                    child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () {
                                                          if (uid != null) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'userInfo')
                                                                .doc(uid)
                                                                .update({
                                                              "favourites":
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                e["id"]
                                                              ])
                                                            }).then((value) => ToastManager
                                                                    .showSuccessToast(
                                                                        context,
                                                                        "${e["name"]} Added to favourites"));
                                                          } else {
                                                            ToastManager
                                                                .showErrorToast(
                                                                    context,
                                                                    "Please login to add to favourites");
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .bookmark_outline,
                                                            size: 12,
                                                            color:
                                                                Colors.black)),
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
                    ...DataLists.topArtists
                        .map((e) => TopArtistCard(data: e))
                        .toList()
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
