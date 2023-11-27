import 'package:flutter/material.dart';

class OrderInfo extends ChangeNotifier {
  String artistId = '';
  String artistName = '';
  String artistImage = '';
  List<String> artistServices = [];

  String date = '';
  String time = '';
  num duration = 0;
  String totalPrice = '';

  List<dynamic> services = [];
  bool paymentStatus = false;

  void setArtistInfo(
      String id, String name, String image, List<String> services) {
    artistId = id;
    artistName = name;
    artistImage = image;
    artistServices = services;
    notifyListeners();
    print(artistId);
  }

  void setOrderInfo(String date, String time, num duration, String totalPrice,
      List<dynamic> services) {
    this.date = date;
    this.time = time;
    this.duration = duration;
    this.totalPrice = totalPrice;
    this.services = services;
    notifyListeners();
    print(this.date);
  }

  void setPaymentStatus(bool status) {
    paymentStatus = status;
    notifyListeners();
    print(paymentStatus);
  }

  void clearOrderInfo() {
    artistId = '';
    artistName = '';
    artistImage = '';

    date = '';
    time = '';
    duration = 0;
    totalPrice = '';

    services = [];
    paymentStatus = false;
    notifyListeners();
    print('Order info cleared');
  }
}
