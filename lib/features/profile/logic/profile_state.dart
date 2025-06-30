import 'package:firebase_auth/firebase_auth.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class NotSignedIn extends ProfileState {}

class SignedIn extends ProfileState {
  final User user;
  SignedIn({required this.user});
}

class ListingsLoding extends ProfileState {}

class ListingsLoded extends ProfileState {}

class ListingsLodingError extends ProfileState {
  final String error;
  ListingsLodingError({required this.error});
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

class NotificationsState extends ProfileState {
  final bool notificationsOn;

  NotificationsState({required this.notificationsOn});
}
