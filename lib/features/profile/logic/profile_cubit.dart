import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void signIn() {
    emit(SignedIn());
  }

  void signOut() {
    emit(NotSignedIn());
  }

  void isSignedIn() {
    if (false) {
      emit(SignedIn());
    } else {
      emit(NotSignedIn());
    }
  }
}
