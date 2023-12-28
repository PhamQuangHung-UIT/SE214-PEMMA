import 'package:budget_buddy/data_sources/repositories/send_verification_email_repository.dart';

class SendVerificationEmailPresenter {
  final _repos = SendVerificationEmailRepository();

  Future<void> sendVerificationEmail(
      String email, String continueUrl, String? languageCode) async {
    await _repos.sendVerificationEmail(email, continueUrl, languageCode);
  }

  Future<void> sendResetPasswordEmail(
      String email, String continueUrl, String? languageCode) async {
    await _repos.sendResetPasswordEmail(email, continueUrl, languageCode);
  }

  Future<void> sendUpdateEmailVerification(
      String email, String continueUrl, String languageCode) async {
    await _repos.sendUpdateEmailVerification(
        email, continueUrl, languageCode);
  }
}
