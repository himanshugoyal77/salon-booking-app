import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  String _query = '';
  List<String> servcies = [];
  double rating = 3;
  String get query => _query;
  bool isResultsFound = false;

  List<Map<String, dynamic>> options = [
    {
      "id": 0,
      "title": "Haircut",
      "isSelected": false,
    },
    {
      "id": 1,
      "title": "Hair Color",
      "isSelected": false,
    },
    {
      "id": 2,
      "title": "Makeup",
      "isSelected": false,
    },
    {
      "id": 3,
      "title": "Spa",
      "isSelected": false,
    },
    {
      "id": 4,
      "title": "Trim & Shave",
      "isSelected": false,
    }
  ];

  void setRating(double value) {
    rating = value;
    notifyListeners();
  }

  void setisResultsFound(bool value) {
    isResultsFound = value;
    notifyListeners();
  }

  void setServices() {
    notifyListeners();
  }

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void setOption(int index) {
    options[index]["isSelected"] = !options[index]["isSelected"];
    servcies = options
        .where((element) => element["isSelected"] == true)
        .map((e) => e["title"].toString())
        .toList();
    notifyListeners();
  }

  void reset() {
    _query = '';
    servcies = [];
    rating = 3;
    options = [
      {
        "id": 0,
        "title": "Haircut",
        "isSelected": false,
      },
      {
        "id": 1,
        "title": "Hair Color",
        "isSelected": false,
      },
      {
        "id": 2,
        "title": "Makeup",
        "isSelected": false,
      },
      {
        "id": 3,
        "title": "Spa",
        "isSelected": false,
      },
      {
        "id": 4,
        "title": "Trim & Shave",
        "isSelected": false,
      }
    ];
    notifyListeners();
  }
}
