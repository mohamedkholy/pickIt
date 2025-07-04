import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/main/logic/main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  UniqueKey indexedStackKey = UniqueKey();
  MainCubit() : super(MainState(selectedIndex: 1, category: "All"));

  void rebuildIndexedStack() {
    indexedStackKey = UniqueKey();
  }

  void moveToBrowse(String? category) {
    emit(MainState(selectedIndex: 1, category: category));
  }
}
