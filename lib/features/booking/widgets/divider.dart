import 'package:flutter/cupertino.dart';
import 'package:salon_app/utils/ui/styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          height: 1,
          width: double.infinity,
          color: Styles.textGray,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
