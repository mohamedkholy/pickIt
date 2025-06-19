import 'package:firebase_auth/firebase_auth.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class NotSignedIn extends ProfileState {}

class SignedIn extends ProfileState {
  final User user;
  SignedIn({required this.user});
}

class UploadingProfilePic extends ProfileState {}

class UploadedProfilePic extends ProfileState {
  final String url;
  UploadedProfilePic({required this.url});
}

class UploadProfilePicError extends ProfileState {
  final String error;
  UploadProfilePicError({required this.error});
}