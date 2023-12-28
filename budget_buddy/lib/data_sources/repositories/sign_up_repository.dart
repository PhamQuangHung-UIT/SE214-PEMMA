import 'package:budget_buddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class SignUpRepository {
  // Create sign up info, but not yet verify the email
  Future<void> signUp(String fullname, String email, String password) async {
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    var list = await auth.fetchSignInMethodsForEmail(email);

    if (list.isNotEmpty) {
      throw FirebaseAuthException(code: 'email-already-in-use');
    }

    var credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    var user = User(userId: credential.user!.uid, fullname: fullname);

    await firestore
        .collection('users')
        .doc(credential.user!.uid)
        .set(user.toMap());
  }
}
