import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salon_app/features/home/view/home_page.dart';
import 'package:salon_app/utils/services/notifications.dart';

class FirebaseFunctions {
  static void saveToFirebase(User user, BuildContext context, String profileUrl,
      String phone, String age, String username, String email, String city) {
    FirebaseFirestore.instance.collection("userInfo").doc(user.uid).set({
      "phone": phone,
      "age": age,
      "username": username,
      //  "imageUrl": ,
      "email": email,
      "city": city,
      "uid": user.uid,
      "profileUrl": profileUrl ??
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
        context, MaterialPageRoute(builder: (ctx) => const HomePage())));
  }
}
