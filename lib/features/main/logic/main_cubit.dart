import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/main/logic/main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState(selectedIndex: 0));

  void moveToBrowse(String? category) {
    emit(MainState(selectedIndex: 1, category: category));
  }
}
