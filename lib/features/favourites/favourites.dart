import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/components/carousel.dart';
import 'package:salon_app/features/home/widgets/topartist.dart';
import 'package:salon_app/utils/data/data.dart';
import 'package:salon_app/utils/ui/styles.dart';
import 'package:salon_app/utils/ui/text.dart';

class FavouriteArtists extends StatefulWidget {
  const FavouriteArtists({super.key});

  @override
  State<FavouriteArtists> createState() => _FavouriteArtistsState();
}

class _FavouriteArtistsState extends State<FavouriteArtists> {
  String? uuid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      uuid = FirebaseAuth.instance.currentUser!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("uuid $uuid");
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Favorite Artists",
                style: AppTextStyles.heading6Bold
                    .copyWith(color: Styles.primaryColor))),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('userInfo')
                .doc(uuid)
                .snapshots(),
            builder: ((context, AsyncSnapshot snapshot) {
              print("snapshot ${snapshot.data["favourites"]}");
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  ...DataLists.hairArtists.map((e) {
                    if (snapshot.data["favourites"].contains(e["id"])) {
                      return TopArtistCard(
                        data: e,
                      );
                    } else {
                      return const SizedBox();
                    }
                  }).toList()
                ],
              );
            })));
  }
}
