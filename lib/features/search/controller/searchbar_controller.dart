import 'package:flutter/cupertino.dart';

class SearchbarController extends ChangeNotifier {
  bool isFilter = false;
  void changeFilter() {
    isFilter = !isFilter;
    print('isFilter: $isFilter from bottom');
    notifyListeners();
  }
}
