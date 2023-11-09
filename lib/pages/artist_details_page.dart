import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/components/maps/cusotm_map.dart';
import 'package:salon_app/utils/styles.dart';
import 'package:readmore/readmore.dart';

class ArtistDetailsPage extends StatefulWidget {
  ArtistDetailsPage({super.key, required this.animation});

  Animation<double> animation;

  @override
  State<ArtistDetailsPage> createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<ArtistDetailsPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> iconList = [
    {'icon': Icons.call, 'text': 'Call', 'func': 'showMap'},
    {'icon': Icons.message, 'text': 'Message', 'func': 'showMap'},
    {'icon': CupertinoIcons.map_fill, 'text': 'Direction', 'func': 'showMap'},
    {'icon': Icons.calendar_today, 'text': 'Schedule', 'func': 'showMap'}
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Styles.secondaryColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Container(
                height: size.height * 0.34,
                padding: const EdgeInsets.fromLTRB(18, 40, 18, 0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              color: Styles.primaryColor,
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Back',
                          style: Styles.body,
                        ),
                      ],
                    ),
                    Positioned(
                      top: size.height * 0.1,
                      child: AnimatedBuilder(
                          animation: widget.animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                  10 * (1 - widget.animation.value) * -1, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      HeroTextChild(
                                        text: '4.5',
                                        style: Styles.body.copyWith(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      'Facial Artist',
                                      style: Styles.heading,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('By Aisha',
                                      style:
                                          Styles.body.copyWith(fontSize: 13)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: '\$ ',
                                        style: Styles.heading
                                            .copyWith(fontSize: 18)),
                                    TextSpan(
                                        text: '${67.00}',
                                        style: Styles.heading),
                                    TextSpan(
                                        text: '/Hour',
                                        style: Styles.body.copyWith(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ])),
                                ],
                              ),
                            );
                          }),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Hero(
                          tag: 'assets/artists/a1.png',
                          child: Image.asset('assets/artists/a1.png')),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.66,
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: iconList
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => CustomMap());
                                      },
                                      child: DetailsCard(
                                        icon: e['icon'],
                                        text: e['text'],
                                      ),
                                    ))
                                .toList()),
                      ),
                      SvgPicture.network(
                        'https://lottie.host/9d582006-0de7-44a2-8b50-5d527c27a6e4/YCYFlWmlDL.lottie',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      //custom tab bar
                      Container(
                        padding: const EdgeInsets.all(3),
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Styles.secondaryColor),
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(0),
                          unselectedLabelColor: Styles.textGray,
                          indicator: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  style: BorderStyle.solid,
                                  width: 0.4),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 168, 160, 160)
                                      .withOpacity(0.6),
                                  offset: const Offset(1, 1),
                                  blurRadius: 9,
                                  spreadRadius: -2,
                                ),
                              ]),
                          labelColor: Colors.black,
                          labelStyle: Styles.body.copyWith(fontSize: 14),
                          isScrollable: true,
                          dividerColor: Colors.yellow,
                          tabs: [
                            Tab(
                              child: Container(
                                width: size.width / 3 - 14,
                                child: Text(
                                  "Services",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Tab(
                                child: Container(
                              width: size.width / 3 - 14,
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  vertical: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 0.8,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "About",
                                textAlign: TextAlign.center,
                              ),
                            )),
                            Tab(
                              child: SizedBox(
                                width: size.width / 3 - 14,
                                child: const Text(
                                  "Reviews",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          ReadMoreText(
                            'The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface. ',
                            trimLines: 3,
                            style: Styles.body.copyWith(
                                fontSize: 13,
                                height: 1.09,
                                color: Colors.grey[600]),
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            moreStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            lessStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          Text('sdfsd'),
                          Text('sdfsd'),
                        ]),
                      )
                    ]),
              ),

              // Expanded(
              //   // ignore: prefer_const_literals_to_create_immutables
              //   child: TabBarView(children: [
              //     // MyLivePage(),
              //     // MyResultPage(),
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 168, 160, 160).withOpacity(0.6),
          offset: Offset(1, 1),
          blurRadius: 9,
          spreadRadius: -2,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.black54,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12, letterSpacing: -0.3),
            )
          ]),
    );
  }
}

class HeroTextChild extends StatelessWidget {
  const HeroTextChild({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}