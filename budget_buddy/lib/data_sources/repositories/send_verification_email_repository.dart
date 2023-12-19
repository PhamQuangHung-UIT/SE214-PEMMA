import 'package:firebase_auth/firebase_auth.dart';

class SendVerificationEmailRepository {
  Future<void> sendVerificationEmail(String email, String continueUrl,
      [String? languageCode]) async {
    var auth = FirebaseAuth.instance;

    // Create an action code settings
    var settings = ActionCodeSettings(
      url: continueUrl,
      androidPackageName: 'com.example.budget_buddy',
      iOSBundleId: 'com.example.budgetBuddy',
      handleCodeInApp: true,
    );

    // Change the localization of verification email
    await auth.setLanguageCode(languageCode);

    // Send the verification email
    await auth.sendSignInLinkToEmail(
        email: email, actionCodeSettings: settings);
  }

  Future<void> sendResetPasswordEmail(String email, String continueUrl,
      [String? languageCode]) async {
    var auth = FirebaseAuth.instance;

    // Create an action code settings
    var settings = ActionCodeSettings(
      url: continueUrl,
      androidPackageName: 'com.example.budget_buddy',
      iOSBundleId: 'com.example.budgetBuddy',
      handleCodeInApp: true,
    );

    // Change the localization of verification email
    await auth.setLanguageCode(languageCode);

    // Send the verification email
    await auth.sendPasswordResetEmail(
        email: email, actionCodeSettings: settings);
  }
}
