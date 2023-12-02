import 'package:budget_buddy/data_sources/repositories/profile_repository.dart';
import 'package:flutter/material.dart';

abstract class MainAppViewContract {
  void onUpdateLocaleSuccess(Locale newLocale);
}

class ProfilePresenter {
  final _repos = ProfileRepository();
  MainAppViewContract? _mainAppViewContract;

  late Locale currentLocale;

  set mainAppViewContract(MainAppViewContract newContract) {
    _mainAppViewContract = newContract;
  }

  Future<void> updateLocale(Locale newLocale) async {
    await _repos.updateLocale(newLocale).then((value) => _mainAppViewContract?.onUpdateLocaleSuccess(newLocale));
  }

  Future<void> loadSettings() async {
    currentLocale = await _repos.currentLocale();
    _mainAppViewContract?.onUpdateLocaleSuccess(currentLocale);
  }
}
