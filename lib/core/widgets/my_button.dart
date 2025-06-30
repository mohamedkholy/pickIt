import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.minWidth,
    this.color,
    this.textStyle,
  });
  final VoidCallback onPressed;
  final String text;
  final double? minWidth;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      color: color ?? MyColors(context).primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: minWidth == null ? 20.w : 0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ?? MyTextStyles(context).font16WhiteBold,
      ),
    );
  }
}
