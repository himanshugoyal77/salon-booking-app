import 'package:flutter/material.dart';
import 'package:salon_app/features/details/view/pages/artist_details_page.dart';
import 'package:salon_app/utils/ui/styles.dart';

class TopArtistCard extends StatelessWidget {
  const TopArtistCard({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              reverseTransitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, animation2) {
                final CurvedAnimation curve = CurvedAnimation(
                    parent: animation, curve: const Interval(0, 0.5));
                return FadeTransition(
                  opacity: curve,
                  child: ArtistDetailsPage(
                    animation: curve,
                    data: data,
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
                tag: data['image'] + data['id'].toString(),
                child: Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(data['image2'] ?? data['image']),
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
                          data['rating'].toString(),
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
                    Text(
                      data['name'],
                      style: Styles.heading
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
