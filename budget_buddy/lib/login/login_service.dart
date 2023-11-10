import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
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
}
