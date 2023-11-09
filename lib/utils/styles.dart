import 'package:flutter/material.dart';

class Styles {
  static const double padding = 20;
  static const double avatarRadius = 15;

  static Color textGray = const Color(0xffC8BDBB);
  static Color bgWhite = const Color(0xffFEFEFE);
  static Color primaryColor = const Color(0xff48201A);
  static Color secondaryColor = const Color(0xffFEF3EC);

  static TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textGray,
  );

  static TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryColor,
  );
}
