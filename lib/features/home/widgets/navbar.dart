import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/utils/ui/styles.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.list_bullet_indent,
              color: Styles.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Hi There',
              style: Styles.heading,
            ),
          ],
        ),
        CircleAvatar(
            foregroundColor: Colors.transparent,
            backgroundColor: Styles.textGray,
            radius: Styles.avatarRadius,
            child: Image.asset('assets/user-image.png'))
      ],
    );
  }
}
