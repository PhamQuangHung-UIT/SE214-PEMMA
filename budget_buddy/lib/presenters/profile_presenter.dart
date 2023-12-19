import 'package:budget_buddy/data_sources/repositories/login_repository.dart';
import 'package:budget_buddy/data_sources/repositories/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class MainAppViewContract {
  void onUpdateLocaleSuccess(Locale newLocale);
}

class ProfilePresenter {
  final _repos = ProfileRepository();

  MainAppViewContract? _mainAppViewContract;

  late Locale currentLocale;

  late bool firstRun;

  late User? user;

  static ProfilePresenter? _instance;

  set mainAppViewContract(MainAppViewContract newContract) {
    _mainAppViewContract = newContract;
  }

  ProfilePresenter._();

  factory ProfilePresenter() {
    _instance ??= ProfilePresenter._();
    return _instance!;
  }

  Future<void> updateLocale(Locale newLocale) async {
    await _repos.updateLocale(newLocale).then((value) {
      currentLocale = newLocale;
      _mainAppViewContract?.onUpdateLocaleSuccess(newLocale);
    });
  }

  Future<void> loadSettings() async {
    currentLocale = await _repos.currentLocale();
    await getFirstRunAndLoginUser();
  }

  // Run all async task and return first run state and current login user
  Future<void> getFirstRunAndLoginUser() async {
    firstRun = await LoginRepository().isFirstTime();
    user = FirebaseAuth.instance.currentUser;
  }
}
