import 'package:budget_buddy/data_sources/repositories/sign_up_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpViewContract {
  void onCreateSignUpInfoSuccess();
  void onCreateSignUpInfoFailed(FirebaseAuthException e);
}

class SignUpPresenter {
  final SignUpRepository _repos = SignUpRepository();
  final SignUpViewContract _viewContract;

  SignUpPresenter(this._viewContract);

  Future<void> signUp(String fullname, String email, String password, String confirmPassword) async {
    _assertFullname(fullname);
    _assertEmail(email);
    _assertPassword(password, confirmPassword);
    _repos
        .signUp(fullname, email, password)
        .then((value) => _viewContract.onCreateSignUpInfoSuccess())
        .catchError((e) => _viewContract.onCreateSignUpInfoFailed(e as FirebaseAuthException));
  }

  void _assertFullname(String fullname) {
    if (fullname.isEmpty) {
      throw FirebaseAuthException(code: 'empty-fullname');
    }
  }

  void _assertEmail(String email) {
    if (!EmailValidator.validate(email)) {
      throw FirebaseAuthException(code: 'invalid-email');
    }
  }

  void _assertPassword(String password, String confirmPassword) {
    if (password.length < 6) {
      throw FirebaseAuthException(code: 'password-6-characters');
    }
    if (password != confirmPassword) {
      throw FirebaseAuthException(code: 'password-not-match');
    }
  }
}
