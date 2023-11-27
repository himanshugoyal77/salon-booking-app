import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/features/auth/controller/siginin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/main.dart';
import 'package:salon_app/utils/services/notifications.dart';
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
    void saveToFirebase(User user) {
      FirebaseFirestore.instance.collection("userInfo").doc(user.uid).set({
        "phone": user.phoneNumber ?? '',
        "age": '',
        "username": user.displayName,
        //  "imageUrl": ,
        "email": user.email,
        "city": 'New York',
        "uid": user.uid,
        "profileUrl": user.photoURL ??
            'https://img.freepik.com/premium-vector/woman-avatar-profile-round-icon_24640-14047.jpg?w=360',
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        'pastAppointments': [],
        'upcomingAppointments': [],
        'reviews': [],
        'favourites': [],
        'notifications': [],
      }).then((value) {
        ToastManager.showErrorToast(context, 'Account created successfully');
      }).then((value) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) =>  Wrapper())));
    }

    return GestureDetector(
      onTap: () async {
        if (text == 'Guest') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  Wrapper()));
        } else {
          Authentication.signInWithGoogle(context: context).then(
            (value) async {
              print(value);
              if (value != null) {
                var collection =
                    FirebaseFirestore.instance.collection('userInfo');
                var docSnapshot = await collection.doc(value.uid).get();
                if (docSnapshot.exists) {
                  print('User already exists');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (ctx) => Wrapper()),
                  );
                } else {
                  saveToFirebase(value);
                }
              }
            },
          );
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
