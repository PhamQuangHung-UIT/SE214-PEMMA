import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReinputPasswordRepository {
  Future<UserCredential> login(String password) async {
    var user = FirebaseAuth.instance.currentUser!;

    var credential =
        EmailAuthProvider.credential(email: user.email!, password: password);
    var userCredential = await user.reauthenticateWithCredential(credential);
    await WriteCache.setString(key: 'password', value: password);
    return userCredential;
  }
}
