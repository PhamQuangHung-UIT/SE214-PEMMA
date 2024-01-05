import 'package:budget_buddy/data_sources/repositories/send_verification_email_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendVerificationEmailPresenter {
  final _repos = SendVerificationEmailRepository();

  Future<void> sendVerificationEmail(
      User user, String continueUrl, String? languageCode) async {
    await _repos.sendVerificationEmail(user, continueUrl, languageCode);
  }

  Future<void> sendResetPasswordEmail(
      String email, String continueUrl, String? languageCode) async {
    await _repos.sendResetPasswordEmail(email, continueUrl, languageCode);
  }

  Future<void> sendUpdateEmailVerification(
      String email, String continueUrl, String? languageCode) async {
    await _repos.sendUpdateEmailVerification(
        email, continueUrl, languageCode);
  }
}
