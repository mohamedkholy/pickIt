import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/profile/data/repos/profile_repo.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
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
}
