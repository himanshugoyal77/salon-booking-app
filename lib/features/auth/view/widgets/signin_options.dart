import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salon_app/features/auth/controller/siginin.dart';
import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/utils/ui/text.dart';

class SignInoptions extends StatelessWidget {
  const SignInoptions({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (text == 'Guest') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Wrapper()));
        } else {
          await Authentication.signInWithGoogle(context: context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4 - 9,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                width: 0.7, color: const Color.fromARGB(214, 158, 158, 158))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text == 'Guest')
              Icon(
                icon,
                color: Colors.black87,
                size: 18,
              ),
            if (text == 'Google')
              Image.network(
                'https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png',
                height: 18,
                width: 18,
              ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: AppTextStyles.bodySmallSemibold,
            ),
          ],
        ),
      ),
    );
  }
}
