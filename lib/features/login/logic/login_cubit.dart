import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/login/data/repos/login_repo.dart';
import 'package:pickit/features/login/logic/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading());
    final result = await _loginRepo.loginWithEmailAndPassword(email, password);
    if (result) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Failed to login"));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    final result = await _loginRepo.loginWithGoogle();
    if (result) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure("Failed to login"));
    }
  }


}





