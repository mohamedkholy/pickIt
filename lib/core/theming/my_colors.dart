import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/features/main/logic/theme_cubit.dart';

class MyColors {
  final BuildContext context;

  MyColors(this.context);

  bool get isDark => context.watch<ThemeCubit>().isDarkMode;

  Color get primaryColor => const Color(0xffE82933);

  Color get primaryColorDark =>
      isDark ? const Color(0xffBB646C) : const Color(0xff994D52);

  Color get secondaryColor =>
      isDark ? const Color(0xff2B2B2B) : const Color(0xffF2E8E8);

  Color get whiteText => isDark ? Colors.white : Colors.black;

  Color get white => isDark ? const Color(0xff141414) : Colors.white;
}
