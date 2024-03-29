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
    apiKey: 'AIzaSyCeSBK_cpV_Wgdr3Gd4QN2TigMV5DXhqTM',
    appId: '1:657948007828:web:89373c4e05b150e6514381',
    messagingSenderId: '657948007828',
    projectId: 'shared-expenses-calculator',
    authDomain: 'shared-expenses-calculator.firebaseapp.com',
    storageBucket: 'shared-expenses-calculator.appspot.com',
    measurementId: 'G-WCHRKCDB4P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkhHZnQAJ1liTcEFDbPbxBTZXLHt_PWR8',
    appId: '1:657948007828:android:676a4bdacc01bc62514381',
    messagingSenderId: '657948007828',
    projectId: 'shared-expenses-calculator',
    storageBucket: 'shared-expenses-calculator.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2_6Ks52CgwzDzU3X8zqIbJ-G0AUgJdLI',
    appId: '1:657948007828:ios:20cf125b3b0ac065514381',
    messagingSenderId: '657948007828',
    projectId: 'shared-expenses-calculator',
    storageBucket: 'shared-expenses-calculator.appspot.com',
    iosBundleId: 'com.example.webCalculator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2_6Ks52CgwzDzU3X8zqIbJ-G0AUgJdLI',
    appId: '1:657948007828:ios:c5f7a85853130a38514381',
    messagingSenderId: '657948007828',
    projectId: 'shared-expenses-calculator',
    storageBucket: 'shared-expenses-calculator.appspot.com',
    iosBundleId: 'com.example.webCalculator.RunnerTests',
  );
}
