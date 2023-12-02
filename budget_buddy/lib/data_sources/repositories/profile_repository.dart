import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
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
}
