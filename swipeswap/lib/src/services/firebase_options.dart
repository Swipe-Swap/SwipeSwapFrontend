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
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
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
    apiKey: 'AIzaSyAltgo76rrNgodFpubCBhgvooalQEIhiHw',
    appId: '1:142866795354:web:e51063e064942cf7cd0163',
    messagingSenderId: '142866795354',
    projectId: 'swipeswap-b1544',
    authDomain: 'swipeswap-b1544.firebaseapp.com',
    storageBucket: 'swipeswap-b1544.appspot.com',
    measurementId: 'G-P5GBS2ZS1H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7ZR6fq7bHf5v8L3cvmJ2tFVeP7_uhncg',
    appId: '1:142866795354:android:63402a9718435167cd0163',
    messagingSenderId: '142866795354',
    projectId: 'swipeswap-b1544',
    storageBucket: 'swipeswap-b1544.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgDGJcbJiDuZD9hXv7SgTe439q4WlozAk',
    appId: '1:142866795354:ios:0fe5e6e00718cc1ecd0163',
    messagingSenderId: '142866795354',
    projectId: 'swipeswap-b1544',
    storageBucket: 'swipeswap-b1544.appspot.com',
    iosClientId:
        '142866795354-g2odk76mo481b9787n3nja97mvip5o0m.apps.googleusercontent.com',
    iosBundleId: 'com.example.swipeswap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgDGJcbJiDuZD9hXv7SgTe439q4WlozAk',
    appId: '1:142866795354:ios:934e49bc05f6bf9fcd0163',
    messagingSenderId: '142866795354',
    projectId: 'swipeswap-b1544',
    storageBucket: 'swipeswap-b1544.appspot.com',
    iosClientId:
        '142866795354-23s0mba8mjt769ppilnue78n2emc9961.apps.googleusercontent.com',
    iosBundleId: 'com.example.swipeswap.RunnerTests',
  );
}