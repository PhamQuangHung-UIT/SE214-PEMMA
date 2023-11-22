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
        apiKey: 'AIzaSyDgfdDYbpRgv-UrMOHbOGD-v5uQcjzCuRE',
        appId: '1:139157950001:web:4362b36b0a9aaeff2e0f10',
        messagingSenderId: '139157950001',
        projectId: 'budget-buddy-se214',
        authDomain: 'budget-buddy-se214.firebaseapp.com',
        storageBucket: 'budget-buddy-se214.appspot.com',
        measurementId: 'G-P6MYN6FXGQ',
    );

    static const FirebaseOptions android = FirebaseOptions(
        apiKey: 'AIzaSyCsjn3twZw_Hg547T7I5ZlclcJZBVbvCRc',
        appId: '1:139157950001:android:548828064d9a57a22e0f10',
        messagingSenderId: '139157950001',
        projectId: 'budget-buddy-se214',
        storageBucket: 'budget-buddy-se214.appspot.com',
    );

    static const FirebaseOptions ios = FirebaseOptions(
        apiKey: 'AIzaSyAkkGrGYHcf_Y6zajmVIU2_fvY2Jp1npzU',
        appId: '1:139157950001:ios:6a96c198b6fc41ea2e0f10',
        messagingSenderId: '139157950001',
        projectId: 'budget-buddy-se214',
        storageBucket: 'budget-buddy-se214.appspot.com',
        iosBundleId: 'com.example.budgetBuddy',
    );
}