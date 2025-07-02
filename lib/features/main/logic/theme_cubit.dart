import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/shared_preferences_constants.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ThemeCubit extends Cubit<ThemeMode> {
  bool isDarkMode = false;
  ThemeCubit() : super(ThemeMode.system);

  void toogleDarkMode(){
    isDarkMode = !isDarkMode;

    (SharedPreferences.getInstance()).then((sp) {
      sp.setBool(SharedPreferencesConstants.darkModeKey, isDarkMode);
    });
    isDarkMode ? emit(ThemeMode.dark) : emit(ThemeMode.light);
  }

  void checkDarkMode(context) async {
    final isDarkMode = (await SharedPreferences.getInstance()).getBool(
      SharedPreferencesConstants.darkModeKey,
    );

    if (isDarkMode == null) {
      this.isDarkMode =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      this.isDarkMode = isDarkMode;
    }
    this.isDarkMode ? emit(ThemeMode.dark) : emit(ThemeMode.light);
  }
}
