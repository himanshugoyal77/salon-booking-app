import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class LatLonController extends ChangeNotifier {
  static double lat = 0.0;
  static double lon = 0.0;
  double nonStaticLat = 0.0;
  double nonStaticLon = 0.0;
  dynamic data = 0;
  String city = "";
  String country = '';
  double temp = 0.0;
  double aqi = 0.0;

  void setAqi(value) {
    aqi = value;
    print("printing aqi from controller");
    print(aqi);
    notifyListeners();
  }

  void setTemp(value) {
    temp = value;
    notifyListeners();
  }

  void setLatLon(la, lo) {
    print(la);
    print(lo);
    lat = la;
    lon = lo;
    nonStaticLat = la;
    nonStaticLon = lo;
    notifyListeners();
  }

  addToList() {}

  setCity(c, i) {
    print(city);
    city = c;
    country = i;
    notifyListeners();
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currenPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // setState(() {
      //   lat = currenPostion.latitude;
      //   lon = currenPostion.longitude;
      // });

      setLatLon(currenPostion.latitude, currenPostion.longitude);
      print("current lat lon" + lat.toString() + " " + lon.toString());
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      Placemark place = placemarks[0];

      country = place.isoCountryCode.toString();
      city = place.locality.toString();
    }
  }
}
