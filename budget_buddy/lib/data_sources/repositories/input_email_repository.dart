import 'package:firebase_auth/firebase_auth.dart';

class InputEmailRepository {
  Future<void> checkEmailExisted(String email) async {
    var auth = FirebaseAuth.instance;
    var res = await auth.fetchSignInMethodsForEmail(email);
    if (res.isEmpty) throw FirebaseAuthException(code: 'user-not-found');
  }
}
