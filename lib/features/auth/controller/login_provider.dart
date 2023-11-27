import 'package:flutter/material.dart';

class AuthMethod extends ChangeNotifier {
  bool isSigin = true;

  void changeMethodTOSignup() {
    isSigin = false;
    notifyListeners();
  }

  void changeMethodTOSignIn() {
    isSigin = true;
    notifyListeners();
  }
}
