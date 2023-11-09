import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:salon_app/services/api/routes.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  List listOfPoints = [];
  List<LatLng> points = [];
  @override
  void initState() {
    super.initState();
    RouteAPI.getRoute('19.24,73.12', '19.30,73.10273975377268').then((value) {
      setState(() {
        listOfPoints = value['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((e) => LatLng(e[0].toDouble(), e[1].toDouble()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 14.5,
        center: LatLng(8.681495, 49.41461),
      ),
      children: [
        TileLayer(
          urlTemplate:
              //'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibXJ1bmFsMTIzNDU2Nzg5IiwiYSI6ImNsbWhzbWF2cTBzajAzcXIybTVoa3g1anQifQ.66Fu05Ii8-NVd-w-C-FSgA',
          //navigation-night-v1
          //streets-v11
          // dark-v11
          // tileBuilder: darkModeTileBuilder,
          // backgroundColor: Colors.transparent,
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 50,
              height: 50,
              point: LatLng(8.681495, 49.41461),
              builder: (context) => lottie.Lottie.network(
                'https://lottie.host/b3adc81e-b0e7-4766-b2a2-0f0232960ec6/7rQZxwdpKU.json',
              ),
            ),
            Marker(
                width: 50,
                height: 50,
                point: LatLng(8.687872, 49.420318),
                builder: (context) => Image.asset('assets/shops.png')),
          ],
        ),
        PolylineLayer(
          polylineCulling: false,
          polylines: [
            Polyline(points: points, color: Colors.blue, strokeWidth: 5)
          ],
        )
      ],
    );
  }
}
