import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:pickit/features/sign_up/logic/sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;

  SignUpCubit(this._signUpRepo) : super(SignUpInitial());

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    final result = await _signUpRepo.signUpWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
    if (result) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure("Failed to sign up"));
    }
  }

  Future<void> signUpWithGoogle() async {
    emit(SignUpLoading());
    final result = await _signUpRepo.signUpWithGoogle();
    if (result) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure("Failed to sign up"));
    }
  }

  Future<void> signUpWithFacebook() async {
    emit(SignUpLoading());
    final result = await _signUpRepo.signUpWithFacebook();
    if (result) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpFailure("Failed to sign up"));
    }
  }
}
