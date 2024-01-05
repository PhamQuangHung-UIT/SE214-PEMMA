import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendVerificationEmailRepository {
  Future<void> sendVerificationEmail(User currentUser, String continueUrl,
      [String? languageCode]) async {
    var auth = FirebaseAuth.instance;

    // Save the current email to cache
    WriteCache.setString(key: 'verifyEmail', value: currentUser.email!);

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
    await currentUser.sendEmailVerification(settings);
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

  Future<void> sendUpdateEmailVerification(
      String newEmail, String continueUrl, String languageCode) async {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser!;

    // Save the current email to cache
    WriteCache.setString(key: 'verifyEmail', value: newEmail);

    var settings = ActionCodeSettings(
      url: continueUrl,
      androidPackageName: 'com.example.budget_buddy',
      iOSBundleId: 'com.example.budgetBuddy',
      handleCodeInApp: true,
    );

    await auth.setLanguageCode(languageCode);

    await user.verifyBeforeUpdateEmail(newEmail, settings);
  }
}
