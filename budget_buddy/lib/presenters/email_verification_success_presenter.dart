import 'package:budget_buddy/data_sources/repositories/email_verification_success_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class EmailVerificationSuccessViewContract {
  void onVerifySuccess(String email);
  void onVerifyFailed(FirebaseAuthException e);
}

class EmailVerificationSuccessPresenter {
  final EmailVerificationSuccessViewContract _viewContract;
  final _repos = EmailVerificationSuccessRepository();

  EmailVerificationSuccessPresenter(this._viewContract);

  Future<void> verifyEmail(String actionCode) async {
    await _repos
        .verifyEmail(actionCode)
        .then((value) => _viewContract.onVerifySuccess(value))
        .catchError((e) => _viewContract.onVerifyFailed(e));
  }
}
