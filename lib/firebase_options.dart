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
    apiKey: 'AIzaSyALqSrsWQ-19dRaLzxVK-FTdSRkJ7Tbfds',
    appId: '1:685066245034:web:d2e4aaf4636a233dd311d3',
    messagingSenderId: '685066245034',
    projectId: 'app-kriptografi',
    authDomain: 'app-kriptografi.firebaseapp.com',
    storageBucket: 'app-kriptografi.appspot.com',
    measurementId: 'G-EVZNR150MT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDBYCzViX-jvvOFfo4Ktcq-EWSiw_Mx6s',
    appId: '1:685066245034:android:66b05886c1c029b4d311d3',
    messagingSenderId: '685066245034',
    projectId: 'app-kriptografi',
    storageBucket: 'app-kriptografi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0ugx-0i8QT5t9MYie3g7_Yu5B4GH083M',
    appId: '1:685066245034:ios:928b7e325f410f5bd311d3',
    messagingSenderId: '685066245034',
    projectId: 'app-kriptografi',
    storageBucket: 'app-kriptografi.appspot.com',
    iosBundleId: 'com.example.sistemKriptografi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0ugx-0i8QT5t9MYie3g7_Yu5B4GH083M',
    appId: '1:685066245034:ios:780cf5887b1b5d90d311d3',
    messagingSenderId: '685066245034',
    projectId: 'app-kriptografi',
    storageBucket: 'app-kriptografi.appspot.com',
    iosBundleId: 'com.example.sistemKriptografi.RunnerTests',
  );
}
