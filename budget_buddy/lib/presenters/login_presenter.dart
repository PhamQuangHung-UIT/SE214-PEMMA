import 'package:budget_buddy/data_sources/repositories/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginViewContract {
  void onLoginSuccess();
  void onLoginError(FirebaseAuthException e);
  void onGetFirstRun(bool firstRun);
}

class LoginPresenter {
  final LoginRepository _repos = LoginRepository();

  LoginViewContract? viewContract;

  LoginPresenter(this.viewContract);

  Future<void> getFirstRun() async {
    bool firstRun = await _repos.isFirstTime();
    viewContract!.onGetFirstRun(firstRun);
  }

  Future<void> loginWithPassword(String username, String password) async {
    assert(username.isNotEmpty && password.isNotEmpty);
    assert(username.length >= 6 && password.length >= 6);
    _repos
        .loginWithPassword(username, password)
        .then((value) => viewContract?.onLoginSuccess())
        .catchError((error) => viewContract?.onLoginError(error as FirebaseAuthException));
  }
}
