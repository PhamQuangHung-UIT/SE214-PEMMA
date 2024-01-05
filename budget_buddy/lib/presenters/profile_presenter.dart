import 'package:budget_buddy/data_sources/repositories/profile_repository.dart';
import 'package:budget_buddy/models/user_model.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class MainAppViewContract {
  void onUpdateLocaleSuccess(Locale newLocale);
}

abstract class ProfileViewContract {
  void onLoadUserDataComplete(user_model.User user);
  void onLoadUserDataFailed(FirebaseException e);
  void onSignOutComplete();
}

class ProfilePresenter {
  final _repos = ProfileRepository();

  MainAppViewContract? _mainAppViewContract;
  ProfileViewContract? _profileViewContract;

  Locale? currentLocale;

  late bool firstRun;

  late User? user;

  static ProfilePresenter? _instance;

  set mainAppViewContract(MainAppViewContract newContract) {
    _mainAppViewContract = newContract;
  }

  set profileViewContract(ProfileViewContract newContract) {
    _profileViewContract = newContract;
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
    _repos.userStateChange().listen(onUserStateChange);
  }

  // Run all async task and return first run state and current login user
  Future<void> getFirstRunAndLoginUser() async {
    firstRun = await _repos.isFirstTime();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> removeFirstRunState() async {
    await _repos.removeFirstTimeState();
    firstRun = false;
  }

  void loadUserData() async {
    await _repos.loadUserData().then<void>((value) {
      value.firebaseUser = user;
      _profileViewContract!.onLoadUserDataComplete(value);
    }).catchError((e) => _profileViewContract!.onLoadUserDataFailed(e));
  }

  Future<void> signOut() async {
    await _repos
        .signOut()
        .then((_) => _profileViewContract!.onSignOutComplete());
  }

  void onUserStateChange(User? newUserState) {
    user = newUserState;
  }

  Future<void> updateUserInfo(user_model.User newUserInfo) async {
    await _repos.updateUserData(newUserInfo);
  }
}
