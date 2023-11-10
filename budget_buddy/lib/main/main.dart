import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main_app.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}
