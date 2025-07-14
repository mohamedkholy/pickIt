import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';

@injectable
class LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await updateUserToken(_auth.currentUser!.uid);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      if (userCredential.user == null) {
        return false;
      }
      updateUserToken(userCredential.user!.uid);
      // final bool? isNewUser = userCredential.additionalUserInfo?.isNewUser;
      // if (isNewUser == true) {
      //   //todo: add user to database
      // }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> updateUserToken(String userId) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .set({"fcmToken": fcmToken});
  }
}
