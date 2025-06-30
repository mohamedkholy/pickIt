import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/core/constants/shared_preferences_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/profile/data/repos/profile_repo.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  late bool isNotificationsOn = false;
  List<Item> items = [];
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(NotSignedIn());
  }

  void isSignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(SignedIn(user: FirebaseAuth.instance.currentUser!));
      await Future.delayed(const Duration(milliseconds: 100));
      getListings();
    } else {
      emit(NotSignedIn());
    }
  }

  Future<void> getListings() async {
    if (this.items.isEmpty) {
      emit(ListingsLoding());
    }
    final items = await _profileRepo.getListings(
      FirebaseAuth.instance.currentUser!.uid,
    );
    if (items != null) {
      this.items = items;
      emit(ListingsLoded());
    } else {
      emit(ListingsLodingError(error: "Failed to load listings"));
    }
  }

  String? getProfilePic() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.photoURL == null) {
      return null;
    }
    return user.photoURL;
  }

  Future<void> uploadProfilePic(String path) async {
    emit(UploadingProfilePic());
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
        "profilePics/${user.uid}",
      );
      await storageRef.putFile(File(path));
      final url = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .set({"profilePic": url});
      await user.updatePhotoURL(url);
      emit(UploadedProfilePic(url: url));
    } catch (e) {
      emit(UploadProfilePicError(error: "Something went wrong"));
    }
  }

  void checkNotificationsState() async {
    emit(
      NotificationsState(
        notificationsOn:
            (await SharedPreferences.getInstance()).getBool(
              SharedPreferencesConstants.notificationsKey,
            ) ??
            false,
      ),
    );
  }

  void toogleNotifications(bool notificationsstate) {
    (SharedPreferences.getInstance()).then((sp) {
      sp.setBool(
        SharedPreferencesConstants.notificationsKey,
        notificationsstate,
      );
      emit(NotificationsState(notificationsOn: notificationsstate));
    });
  }

  Future<void> openHelpCenter() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@pickIt.com',
      query: Uri.encodeFull(
        'subject=Help Center Inquiry&body=Describe your issue here...',
      ),
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> openPolicy() async {
    final Uri emailLaunchUri = Uri.parse(
      "https://sites.google.com/view/pickit-app",
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
