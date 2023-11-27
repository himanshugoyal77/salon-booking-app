import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:salon_app/features/booking/book.dart';
import 'package:salon_app/features/booking/controllers/orderdata.dart';
import 'package:salon_app/features/details/view/widgets/cusotm_map.dart';
import 'package:salon_app/features/details/view/widgets/available_dates.dart';
import 'package:salon_app/utils/data/pastwork.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:readmore/readmore.dart';
import 'package:salon_app/utils/ui/text.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistDetailsPage extends StatefulWidget {
  ArtistDetailsPage({super.key, required this.animation, required this.data});

  Animation<double> animation;
  dynamic data;

  @override
  State<ArtistDetailsPage> createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<ArtistDetailsPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> iconList = [
    {'icon': Icons.call, 'text': 'Call', 'func': const CustomMap()},
    {'icon': Icons.share_outlined, 'text': 'Share', 'func': 'sharefunc'},
    {
      'icon': CupertinoIcons.map_fill,
      'text': 'Direction',
      'func': const CustomMap()
    },
    {
      'icon': Icons.calendar_today,
      'text': 'Schedule',
      'func': const AvailableModal()
    }
  ];
  Future saveAndShare(Uint8List? bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes!);

    await Share.shareFiles(
      [image.path],
      text: 'Aisha',
      subject: 'Face Art',
    );
  }

  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final OrderInfo orderInfoProvider = Provider.of<OrderInfo>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Styles.secondaryColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: size.height * 0.40,
                  color: Styles.secondaryColor,
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
                        left: 10,
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
                                        Text(
                                          widget.data['rating'].toString(),
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
                                        widget.data['profession'],
                                        style: Styles.heading,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('By ${widget.data['name']}',
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
                                          text: widget.data['per_hour_cost']
                                              .toString(),
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
                        bottom: 0,
                        right: -30,
                        child: Hero(
                            tag: widget.data['image'] +
                                widget.data['id'].toString(),
                            child: Image.asset(
                              widget.data['image2'] ?? widget.data['image'],
                              height: 250,
                              width: 250,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height * 0.60,
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: iconList
                                .map((e) => GestureDetector(
                                      onTap: () async {
                                        if (e['text'] == 'Share') {
                                          final image =
                                              await screenshotController
                                                  .capture();
                                          await saveAndShare(image);
                                        } else if (e['text'] == 'Call') {
                                          const url = 'tel:+911234567890';
                                          void call() async {
                                            if (await canLaunchUrl(Uri(
                                                scheme: 'tel',
                                                path: '8879623395'))) {
                                              await launchUrl(Uri.parse(url));
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          }

                                          call();
                                        } else {
                                          showModalBottomSheet(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              )),
                                              context: context,
                                              builder: (context) => e['func']);
                                        }
                                      },
                                      child: DetailsCard(
                                        icon: e['icon'],
                                        text: e['text'],
                                      ),
                                    ))
                                .toList()),
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
                                  color:
                                      const Color.fromARGB(255, 168, 160, 160)
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
                              child: SizedBox(
                                width: size.width / 3 - 14,
                                child: const Text(
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
                        height: 18,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          ReadMoreText(
                            widget.data['description'],
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
                          const Text('sdfsd'),
                          const Text('sdfsd'),
                        ]),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Recent Works",
                        style: AppTextStyles.bodyRegularBold
                            .copyWith(fontSize: 16, color: Styles.primaryColor),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: pastWork
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        e,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            backgroundColor: Styles.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            orderInfoProvider.setArtistInfo(
                                widget.data['id'].toString(),
                                widget.data['name'],
                                widget.data['image'],
                                widget.data['specialties']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Book(),
                              ),
                            );
                          },
                          child: Text('Book Appointment',
                              style: AppTextStyles.heading6.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        height: 18,
                      ),
                    ]),
              ),
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
      height: 65,
      width: 65,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          boxShadow: [],
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.1), width: 0.7),
          borderRadius: BorderRadius.circular(10)),
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
            Text(text, style: AppTextStyles.bodyExtraSmall)
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
