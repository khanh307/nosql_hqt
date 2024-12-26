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
    apiKey: 'AIzaSyBGMcLe25i96-zKXdbKHbUp82b5gIoIq9w',
    appId: '1:420284116329:web:5674d192c1aa2c28e721f8',
    messagingSenderId: '420284116329',
    projectId: 'nosqlcsdl',
    authDomain: 'nosqlcsdl.firebaseapp.com',
    databaseURL: 'https://nosqlcsdl-default-rtdb.firebaseio.com',
    storageBucket: 'nosqlcsdl.firebasestorage.app',
    measurementId: 'G-JMCGWZH1XL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDc5kFNlxg6FXJmfKuUceWgAqAY0R1AjG4',
    appId: '1:420284116329:android:d69a76674cb8d76be721f8',
    messagingSenderId: '420284116329',
    projectId: 'nosqlcsdl',
    databaseURL: 'https://nosqlcsdl-default-rtdb.firebaseio.com',
    storageBucket: 'nosqlcsdl.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0q6LooURQgjJUs7rVwBoIDbCoofcMjtw',
    appId: '1:420284116329:ios:7edb76eb54879253e721f8',
    messagingSenderId: '420284116329',
    projectId: 'nosqlcsdl',
    databaseURL: 'https://nosqlcsdl-default-rtdb.firebaseio.com',
    storageBucket: 'nosqlcsdl.firebasestorage.app',
    iosBundleId: 'com.qth.fitnessTracker',
  );
}