import 'package:budget_buddy/data_sources/repositories/reinput_password_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ReinputPasswordViewContract {
  void onLoginSuccess(UserCredential credential);
  void onLoginError(FirebaseException e);
}

class ReinputPasswordPresenter {
  final ReinputPasswordViewContract _viewContract;
  final _repos = ReinputPasswordRepository();

  ReinputPasswordPresenter(this._viewContract);

  Future<void> login(String password) async {
    await _repos
        .login(password)
        .then(_viewContract.onLoginSuccess)
        .catchError((e) => _viewContract.onLoginError(e));
  }
}
