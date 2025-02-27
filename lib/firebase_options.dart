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

  static FirebaseOptions web = const FirebaseOptions(
    apiKey: 'AIzaSyBaRok9pwdAHqZsodUiKeBc3qa9XpU5bK0',
    appId: '1:964974384940:web:f885707989ad77415cfe89',
    messagingSenderId: '964974384940',
    projectId: 'flutter-chat-cc6d8',
    authDomain: 'flutter-chat-cc6d8.firebaseapp.com',
    storageBucket: 'flutter-chat-cc6d8.appspot.com',
  );

  static FirebaseOptions android = const FirebaseOptions(
    apiKey: 'AIzaSyCVwSiMZXFNEe9KnzHfJejARtSIdfOvPnw',
    appId: '1:964974384940:android:893af80d427d33c25cfe89',
    messagingSenderId: '964974384940',
    projectId: 'flutter-chat-cc6d8',
    storageBucket: 'flutter-chat-cc6d8.appspot.com',
  );

  static FirebaseOptions ios = const FirebaseOptions(
    apiKey: 'AIzaSyCkaIjSXJNQ5vkA7tJomJxZePyUYoSfacI',
    appId: '1:964974384940:ios:83d4227c5dc534355cfe89',
    messagingSenderId: '964974384940',
    projectId: 'flutter-chat-cc6d8',
    storageBucket: 'flutter-chat-cc6d8.appspot.com',
    iosBundleId: 'com.example.samples',
  );

  static FirebaseOptions macos = const FirebaseOptions(
    apiKey: 'AIzaSyCkaIjSXJNQ5vkA7tJomJxZePyUYoSfacI',
    appId: '1:964974384940:ios:83d4227c5dc534355cfe89',
    messagingSenderId: '964974384940',
    projectId: 'flutter-chat-cc6d8',
    storageBucket: 'flutter-chat-cc6d8.appspot.com',
    iosBundleId: 'com.example.samples',
  );
}
