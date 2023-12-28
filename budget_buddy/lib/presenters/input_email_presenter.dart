import 'package:budget_buddy/data_sources/repositories/input_email_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class InputEmailViewContract {
  void onCheckEmailExistedSuccess(String email);
  void onCheckEmailExistedFailed(FirebaseAuthException e);
}

class InputEmailPresenter {
  final InputEmailViewContract _viewContract;
  final InputEmailRepository _repos = InputEmailRepository();

  InputEmailPresenter(this._viewContract);

  Future<void> checkEmailExisted(String email) async {
    await _repos
        .checkEmailExisted(email)
        .then((value) => _viewContract.onCheckEmailExistedSuccess(email))
        .catchError((e) => _viewContract.onCheckEmailExistedFailed(e));
  }
}
