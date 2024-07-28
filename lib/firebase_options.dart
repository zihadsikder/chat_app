// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyA7GwPkho9C53mefGoFdd7qkAvLpp7_x4U',
    appId: '1:899705046916:web:5cf366f51328e7912bbfd1',
    messagingSenderId: '899705046916',
    projectId: 'chatapptute-aa808',
    authDomain: 'chatapptute-aa808.firebaseapp.com',
    storageBucket: 'chatapptute-aa808.appspot.com',
    measurementId: 'G-Y22RCG6Q54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPD6W8HodjRmXLXSxG0OlojE_kXxTkTiM',
    appId: '1:899705046916:android:8b65f76a6a2c49532bbfd1',
    messagingSenderId: '899705046916',
    projectId: 'chatapptute-aa808',
    storageBucket: 'chatapptute-aa808.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4qFqonf2nh0DBWKCQf9mFed3Qtc7kzQA',
    appId: '1:899705046916:ios:110c55f6612addd12bbfd1',
    messagingSenderId: '899705046916',
    projectId: 'chatapptute-aa808',
    storageBucket: 'chatapptute-aa808.appspot.com',
    iosBundleId: 'com.chat.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4qFqonf2nh0DBWKCQf9mFed3Qtc7kzQA',
    appId: '1:899705046916:ios:3c86b94c3e4178922bbfd1',
    messagingSenderId: '899705046916',
    projectId: 'chatapptute-aa808',
    storageBucket: 'chatapptute-aa808.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA7GwPkho9C53mefGoFdd7qkAvLpp7_x4U',
    appId: '1:899705046916:web:0b7c8393a13632092bbfd1',
    messagingSenderId: '899705046916',
    projectId: 'chatapptute-aa808',
    authDomain: 'chatapptute-aa808.firebaseapp.com',
    storageBucket: 'chatapptute-aa808.appspot.com',
    measurementId: 'G-34VG4XFGQM',
  );
}
