// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCVrfqtY93byhGtC3H10o4chPK1zr6Wdh4',
    appId: '1:765129290156:web:5938c07b565359ff9c8a09',
    messagingSenderId: '765129290156',
    projectId: 'salon-app-81649',
    authDomain: 'salon-app-81649.firebaseapp.com',
    storageBucket: 'salon-app-81649.appspot.com',
    measurementId: 'G-V4V4GVPXP3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfUgrY852xmuRMK8jaL8d9XLgjB4mexgw',
    appId: '1:765129290156:android:3051b10abd5255f29c8a09',
    messagingSenderId: '765129290156',
    projectId: 'salon-app-81649',
    storageBucket: 'salon-app-81649.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcpyGZ-MAtEYtIJUVJehVObcnkIQvV_U4',
    appId: '1:765129290156:ios:73e5b798a267053f9c8a09',
    messagingSenderId: '765129290156',
    projectId: 'salon-app-81649',
    storageBucket: 'salon-app-81649.appspot.com',
    androidClientId: '765129290156-vof81mrprgfprbl675ivik29ls83pjhb.apps.googleusercontent.com',
    iosClientId: '765129290156-u19pd9dmddg4fekjlmsto3ctugmtam38.apps.googleusercontent.com',
    iosBundleId: 'com.example.salonApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcpyGZ-MAtEYtIJUVJehVObcnkIQvV_U4',
    appId: '1:765129290156:ios:73e5b798a267053f9c8a09',
    messagingSenderId: '765129290156',
    projectId: 'salon-app-81649',
    storageBucket: 'salon-app-81649.appspot.com',
    androidClientId: '765129290156-vof81mrprgfprbl675ivik29ls83pjhb.apps.googleusercontent.com',
    iosClientId: '765129290156-u19pd9dmddg4fekjlmsto3ctugmtam38.apps.googleusercontent.com',
    iosBundleId: 'com.example.salonApp',
  );
}
