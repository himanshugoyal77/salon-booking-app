import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/components/carousel.dart';
import 'package:salon_app/features/home/widgets/topartist.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

class FavouriteArtists extends StatelessWidget {
  const FavouriteArtists({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text("Favorite Artists",
                  style: AppTextStyles.heading6Bold
                      .copyWith(color: Styles.primaryColor)),
              const SizedBox(height: 12),
              TopArtistCard(size: size),
              TopArtistCard(size: size),
              TopArtistCard(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
