import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser?.updateDisplayName(name);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return result.user != null;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signUpWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final accessToken = loginResult.accessToken;

        final facebookAuthCredential = FacebookAuthProvider.credential(
          accessToken!.token,
        );

        final result = await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );
        return result.user != null;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: loginResult.message,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
