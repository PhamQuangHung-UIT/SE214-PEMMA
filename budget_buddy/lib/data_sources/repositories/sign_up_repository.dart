import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class SignUpRepository {
  // Create sign up info, but not yet verify the email
  Future<void> signUp(String fullname, String email, String password) async {
    var auth = FirebaseAuth.instance;
    var list = await auth.fetchSignInMethodsForEmail(email);

    if (list.isNotEmpty) {
      throw FirebaseAuthException(code: 'email-already-in-use');
    }

    var map = {
      'fullname': fullname,
      'email': email,
      'password': password,
    };

    await WriteCache.setJson(key: 'SignUpInfo', value: map);
  }
}
