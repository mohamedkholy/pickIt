import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
  });
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.primaryColorDark),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(iconPath, width: 24.r, height: 24.r),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(text, style: MyTextStyles.font14BrownBold),
            ),
          ],
        ),
      ),
    );
  }
}
