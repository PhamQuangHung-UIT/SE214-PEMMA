import 'package:budget_buddy/data_sources/repositories/edit_profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class EditProfileViewContract {
  void onUpdateComplete();
  void onUpdateError(FirebaseException e);
}

class EditProfilePresenter {
  late String oldEmail;
  late String oldFullname;

  final EditProfileViewContract _viewContract;
  final EditProfileRepository _repos = EditProfileRepository();

  EditProfilePresenter(this._viewContract);

  Future<void> updateUserData(
      String fullname, String newEmail, String continueUrl) async {
    if (fullname != oldFullname) {
      await _repos
          .updateFullname(fullname)
          .then((value) => _viewContract.onUpdateComplete())
          .catchError((e) => _viewContract.onUpdateError(e));
    }
    if (newEmail != oldEmail) {
      _viewContract.onUpdateError(FirebaseAuthException(code: 'requires-recent-login'));
    }
  }
}
