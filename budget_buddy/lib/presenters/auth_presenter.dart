import 'package:budget_buddy/data_sources/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPresenter {
  final _repos = AuthRepository();

  AuthPresenter();

  Future<Map<String, dynamic>> handleAuthData(
      String? mode, String? code) async {
    if (code == null || mode == null) {
      throw FirebaseAuthException(code: 'empty-code');
    }

    switch (mode) {
      case 'resetPassword':
        var email = await _repos.verifyResetPasswordCode(code);
        return {
          'email': email,
          'actionCode': code,
        };
      case 'verifyEmail':
      case 'verifyAndChangeEmail':
        await _repos.verifyActionCode(code);
        return {
          'actionCode': code,
        };
      default:
        return {};
    }
  }
}
