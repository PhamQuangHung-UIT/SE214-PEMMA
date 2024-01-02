import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class EmailVerificationSuccessRepository {
  Future<String> verifyEmail(String actionCode) async {
    await FirebaseAuth.instance.applyActionCode(actionCode);
    String email = await ReadCache.getString(key: 'verifyEmail');
    String password = await ReadCache.getString(key: 'password');
    var credential =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential);
    await FirebaseAuth.instance.currentUser!.reload();
    return email;
  }
}
