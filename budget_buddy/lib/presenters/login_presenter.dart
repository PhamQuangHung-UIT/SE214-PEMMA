import 'package:budget_buddy/data_sources/repositories/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginViewContract {
  void onLoginSuccess();
  void onLoginError(FirebaseException e);
  void onGetFirstRun(bool firstRun);
}

class LoginPresenter {
  final LoginRepository _repos = LoginRepository();

  final LoginViewContract viewContract;

  LoginPresenter(this.viewContract);

  Future<void> loginWithPassword(String email, String password) async {
    await _repos
        .loginWithPassword(email, password)
        .then((value) => viewContract.onLoginSuccess())
        .catchError((error) => viewContract.onLoginError(error as FirebaseAuthException));
  }

  Future<void> loginWithGoogle() async {
    await _repos
        .loginWithGoogle()
        .then((value) => viewContract.onLoginSuccess())
        .catchError((error) => viewContract.onLoginError(error as FirebaseAuthException));
  }

  Future<void> loginWithFacebook() async {
    await _repos
        .loginWithFacebook()
        .then((value) => viewContract.onLoginSuccess())
        .catchError((error) => viewContract.onLoginError(error as FirebaseAuthException));
  }
}
