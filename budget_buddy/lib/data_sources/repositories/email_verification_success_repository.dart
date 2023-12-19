import 'package:budget_buddy/models/user_model.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class EmailVerificationSuccessRepository {
  Future<String> verifyEmail(String actionCode) async {
    var firestore = FirebaseFirestore.instance;
    var auth = FirebaseAuth.instance;

    var signUpInfo =
        (await ReadCache.getJson(key: "SignUpInfo")) as Map<String, dynamic>;

    String fullname = signUpInfo['fullname'];
    String email = signUpInfo['email'];
    String password = signUpInfo['password'];

    // await auth.applyActionCode(actionCode).catchError((_) {},
    //     test: (error) =>
    //         (error is FirebaseAuthException) && error.code == 'user-not-found');

    var credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    var user = User(userId: credential.user!.uid, fullname: fullname);

    await firestore
        .collection('users')
        .doc(credential.user!.uid)
        .set(user.toMap());
    return email;
  }
}
