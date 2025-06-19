import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/sign_up/logic/sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void signUp(String email, String password) {
    emit(SignUpLoading());
    // TODO: Implement sign up logic
    emit(SignUpSuccess());
  }
}
