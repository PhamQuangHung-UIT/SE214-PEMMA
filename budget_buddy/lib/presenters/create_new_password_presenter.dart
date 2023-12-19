import 'package:budget_buddy/data_sources/repositories/create_new_password_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateNewPasswordViewContract {
  void onCreateNewPasswordSuccess();
  void onCreateNewPasswordFalied(FirebaseAuthException e);
}

class CreateNewPasswordPresenter {
  final CreateNewPasswordViewContract _viewContract;
  final _repos = CreateNewPasswordRepository();

  CreateNewPasswordPresenter(this._viewContract);

  Future<void> resetPassword(String password, String confirmPassword, String actionCode) async {
    try {
      if (password != confirmPassword) {
        throw FirebaseAuthException(code: 'password-not-match');
      }
      await _repos
          .resetPassword(password, actionCode)
          .then((value) => _viewContract.onCreateNewPasswordSuccess())
          .catchError((e) => _viewContract.onCreateNewPasswordFalied(e));
    } on FirebaseAuthException catch (e) {
      _viewContract.onCreateNewPasswordFalied(e);
    }
  }
}
