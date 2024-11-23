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
    apiKey: 'AIzaSyAy2frbRDFHp0V2KV7UkBJdT5JlXDPTWe8',
    appId: '1:751302366277:web:f9be7590ab64bc1e653f2c',
    messagingSenderId: '751302366277',
    projectId: 'baby-name-7d86b',
    authDomain: 'baby-name-7d86b.firebaseapp.com',
    storageBucket: 'baby-name-7d86b.firebasestorage.app',
    measurementId: 'G-HZH2F5WWTE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5ymOG_adFAUG9UMeqLHbSa76zx0StiqI',
    appId: '1:751302366277:android:770de9e9222c866e653f2c',
    messagingSenderId: '751302366277',
    projectId: 'baby-name-7d86b',
    storageBucket: 'baby-name-7d86b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCO8z7bFQW_ajEz-0s7JBj7dp_MhAvab7c',
    appId: '1:751302366277:ios:2d7d09d73ca558e8653f2c',
    messagingSenderId: '751302366277',
    projectId: 'baby-name-7d86b',
    storageBucket: 'baby-name-7d86b.firebasestorage.app',
    iosBundleId: 'com.example.babyname',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCO8z7bFQW_ajEz-0s7JBj7dp_MhAvab7c',
    appId: '1:751302366277:ios:2d7d09d73ca558e8653f2c',
    messagingSenderId: '751302366277',
    projectId: 'baby-name-7d86b',
    storageBucket: 'baby-name-7d86b.firebasestorage.app',
    iosBundleId: 'com.example.babyname',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAy2frbRDFHp0V2KV7UkBJdT5JlXDPTWe8',
    appId: '1:751302366277:web:b7ab443e4fe4d861653f2c',
    messagingSenderId: '751302366277',
    projectId: 'baby-name-7d86b',
    authDomain: 'baby-name-7d86b.firebaseapp.com',
    storageBucket: 'baby-name-7d86b.firebasestorage.app',
    measurementId: 'G-G2QVC4MPP8',
  );
}