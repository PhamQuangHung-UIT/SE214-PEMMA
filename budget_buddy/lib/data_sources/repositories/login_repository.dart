import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  // return true if the user runs the app on the first time
  Future<bool> isFirstTime() async {
    debugPrint('Prepared to called shared preferences');
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool("firstTime") == null;
  }

  // remove the user's local state of run the app on the first time
  Future<void> removeFirstTimeState() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTime', false);
  }

  Future<void> loginWithPassword(String username, String password) async {
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: username, password: password);
  }

  Future<void> loginWithGoogle() async {
    var googleSignIn = GoogleSignIn();

    // Trigger the authentication flow
    var googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in using the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      // Throw an exception notify that sign up process was aborted
      throw FirebaseAuthException(code: 'sign-up-abort');
    }
  }

  Future<void> loginWithFacebook() async {
    var result = await FacebookAuth.instance.login();
    if (result.accessToken != null) {
      //Create a new credential
      var credential = FacebookAuthProvider.credential(result.accessToken!.token);

      // Sign in using the credential
      var user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      var userData = await FacebookAuth.instance.getUserData();

      debugPrint("$user\n$userData");
    }
  }
}
