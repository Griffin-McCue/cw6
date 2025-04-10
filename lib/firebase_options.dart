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
    apiKey: 'AIzaSyCpHIMoWAbLJHITUXknvBs5AbIsqjwd_EI',
    appId: '1:19310457485:web:dfdbc4e1cff93c4c98a8c4',
    messagingSenderId: '19310457485',
    projectId: 'coursework6-e3abe',
    authDomain: 'coursework6-e3abe.firebaseapp.com',
    storageBucket: 'coursework6-e3abe.firebasestorage.app',
    measurementId: 'G-XYK0MV2PD1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB08S0AE974MFQ3_sD5ZgdnyP01jAe8cs8',
    appId: '1:19310457485:android:3f876fea3229101598a8c4',
    messagingSenderId: '19310457485',
    projectId: 'coursework6-e3abe',
    storageBucket: 'coursework6-e3abe.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_zav6bHMju8fVQDK_vQx0U-3Y5Td9MMw',
    appId: '1:19310457485:ios:472447f3c4f94f0998a8c4',
    messagingSenderId: '19310457485',
    projectId: 'coursework6-e3abe',
    storageBucket: 'coursework6-e3abe.firebasestorage.app',
    iosBundleId: 'com.example.cw6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_zav6bHMju8fVQDK_vQx0U-3Y5Td9MMw',
    appId: '1:19310457485:ios:472447f3c4f94f0998a8c4',
    messagingSenderId: '19310457485',
    projectId: 'coursework6-e3abe',
    storageBucket: 'coursework6-e3abe.firebasestorage.app',
    iosBundleId: 'com.example.cw6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCpHIMoWAbLJHITUXknvBs5AbIsqjwd_EI',
    appId: '1:19310457485:web:0c38031b97221c9f98a8c4',
    messagingSenderId: '19310457485',
    projectId: 'coursework6-e3abe',
    authDomain: 'coursework6-e3abe.firebaseapp.com',
    storageBucket: 'coursework6-e3abe.firebasestorage.app',
    measurementId: 'G-P4KMQLB6S0',
  );
}
