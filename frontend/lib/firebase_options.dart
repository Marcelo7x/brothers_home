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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyASBAEblOK3ktj2GtEc1LlnVHX2hNQDRG0',
    appId: '1:676505043915:web:34d3065c968ec3da926c4e',
    messagingSenderId: '676505043915',
    projectId: 'family-rep',
    authDomain: 'family-rep.firebaseapp.com',
    storageBucket: 'family-rep.appspot.com',
    measurementId: 'G-WQ7BLPJRCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzVp9TBr34GXXtnqva2oaqSPVc2cCog-M',
    appId: '1:676505043915:android:9b5f6fa8d86bf384926c4e',
    messagingSenderId: '676505043915',
    projectId: 'family-rep',
    storageBucket: 'family-rep.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA31Wd6Lxk8kJB5qqVYY9R7uTB2RMWG5FQ',
    appId: '1:676505043915:ios:51da9d3b33175154926c4e',
    messagingSenderId: '676505043915',
    projectId: 'family-rep',
    storageBucket: 'family-rep.appspot.com',
    iosClientId: '676505043915-a22fvmvdqok2jtgq2k698t87vh3gmb31.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontend',
  );
}