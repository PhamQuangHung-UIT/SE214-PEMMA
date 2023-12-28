import 'package:firebase_auth/firebase_auth.dart';

class CreateNewPasswordRepository {
  Future<void> resetPassword(String newPassword, String actionCode) async {
    var auth = FirebaseAuth.instance;

    await auth.confirmPasswordReset(code: actionCode, newPassword: newPassword);
  }
}
