import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/helpers/font_weight_helper.dart';
import 'package:pickit/core/theming/my_colors.dart';

class MyTextStyles {
  final BuildContext context;
  late final MyColors colors = MyColors(context);

  MyTextStyles(this.context);

  TextStyle get font16BrownRegular => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.primaryColorDark,
      );

  TextStyle get font14BrownRegular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.primaryColorDark,
      );

  TextStyle get font14BrownBold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.primaryColorDark,
      );

  TextStyle get font12BrownBold => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.primaryColorDark,
      );

  TextStyle get font14BlackRegular => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.whiteText,
      );

  TextStyle get font14BlackBold => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font18BlackBold => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font22BlackBold => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font16BlackMedium => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.medium,
        color: colors.whiteText,
      );

  TextStyle get font16BlackBold => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font13BlackRegular => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.whiteText,
      );

  TextStyle get font13BrownRegular => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.primaryColorDark,
      );

  TextStyle get font16WhiteBold => TextStyle(
        fontSize: 16,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font14WhiteBold =>  TextStyle(
        fontSize: 14,
        fontWeight: FontWeightHelper.bold,
        color: colors.whiteText,
      );

  TextStyle get font16BlackRegular => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.regular,
        color: colors.whiteText,
      );

  TextStyle get font12MediumBlack => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: colors.whiteText,
      );

  TextStyle get font14MediumBlack => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: colors.whiteText,
      );
}
