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
    apiKey: 'AIzaSyBrqmwAaaCv58ahU9wZ0A4-lEF-oiPWdbs',
    appId: '1:217097536743:web:90a9cb08abfea77eef0e42',
    messagingSenderId: '217097536743',
    projectId: 'flutterapplication1-f969b',
    authDomain: 'flutterapplication1-f969b.firebaseapp.com',
    storageBucket: 'flutterapplication1-f969b.firebasestorage.app',
    measurementId: 'G-1XTVER8883',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKOuGUN0IIvKBoFcve1INrOmKCwMqSyYk',
    appId: '1:217097536743:android:5b45204c959c3646ef0e42',
    messagingSenderId: '217097536743',
    projectId: 'flutterapplication1-f969b',
    storageBucket: 'flutterapplication1-f969b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcRWbmMgVCArfNws-ib6x-gwa-UeW0-Ec',
    appId: '1:217097536743:ios:e7cc2fcad11de991ef0e42',
    messagingSenderId: '217097536743',
    projectId: 'flutterapplication1-f969b',
    storageBucket: 'flutterapplication1-f969b.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcRWbmMgVCArfNws-ib6x-gwa-UeW0-Ec',
    appId: '1:217097536743:ios:e7cc2fcad11de991ef0e42',
    messagingSenderId: '217097536743',
    projectId: 'flutterapplication1-f969b',
    storageBucket: 'flutterapplication1-f969b.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBrqmwAaaCv58ahU9wZ0A4-lEF-oiPWdbs',
    appId: '1:217097536743:web:8d56863e6462e15eef0e42',
    messagingSenderId: '217097536743',
    projectId: 'flutterapplication1-f969b',
    authDomain: 'flutterapplication1-f969b.firebaseapp.com',
    storageBucket: 'flutterapplication1-f969b.firebasestorage.app',
    measurementId: 'G-7HJLNQ06W6',
  );
}
