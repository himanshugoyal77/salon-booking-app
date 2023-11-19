import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDate extends ChangeNotifier {
  String formatDate(DateTime date) => DateFormat("EEE, MMMM d").format(date);
  var formatedDate;
  bool closeDialog = false;
  BookingDate() {
    formatedDate = formatDate(DateTime.now());
  }

  void closeDialogBox() {
    closeDialog = !closeDialog;
    notifyListeners();
  }

  void changeDate(DateTime date) {
    formatedDate = formatDate(date);
    notifyListeners();
  }
}
