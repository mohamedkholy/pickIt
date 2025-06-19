import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(NotSignedIn());
  }

  void isSignedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(SignedIn(user: FirebaseAuth.instance.currentUser!));
    } else {
      emit(NotSignedIn());
    }
  }

  Future<String?> getProfilePic() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    final userDoc =
        await FirebaseFirestore.instance
            .collection(FirestoreConstants.usersCollection)
            .doc(user.uid)
            .get();
    return userDoc.data()?["profilePic"] as String?;
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
      emit(UploadedProfilePic(url: url));
    } catch (e) {
      emit(UploadProfilePicError(error: "Something went wrong"));
    }
  }
}
