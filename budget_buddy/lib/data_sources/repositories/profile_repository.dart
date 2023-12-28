import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:budget_buddy/models/user_model.dart' as user_model;

class ProfileRepository {
  // return true if the user runs the app on the first time
  Future<bool> isFirstTime() async {
    debugPrint('Prepared to called shared preferences');
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("firstTime") == null;
  }

  // remove the user's local state of run the app on the first time
  Future<void> removeFirstTimeState() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTime', false);
  }

  Stream<User?> userStateChange() {
    return FirebaseAuth.instance.userChanges();
  }

  Future<void> updateLocale(Locale newLocale) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLocale.languageCode);
  }

  Future<Locale> currentLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    if (languageCode == null) {
      // return the default app locale
      return const Locale('en');
    }
    return Locale(languageCode);
  }

  Future<user_model.User> loadUserData() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var result =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var user = user_model.User.fromMap(result.data()!);
    return user;
  }

  Future<void> signOut() => FirebaseAuth.instance.signOut();

  Future<void> updateUserData(user_model.User newUserData) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(newUserData.toMap());
  }
}
