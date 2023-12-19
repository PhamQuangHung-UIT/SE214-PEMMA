import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<String> verifyResetPasswordCode(String code) =>
      FirebaseAuth.instance.verifyPasswordResetCode(code);

  Future<ActionCodeInfo> verifyActionCode(String code) =>
      FirebaseAuth.instance.checkActionCode(code);
}