import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class NotSignedInWidget extends StatelessWidget {
  const NotSignedInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_pin_circle_rounded,
            size: 56.dg,
            color: MyColors.primaryColor,
          ),
          SizedBox(height: 16.h),
          Text("You are not signed in", style: MyTextStyles.font18BlackBold),
          SizedBox(height: 8.h),
          Text(
            "Sign in to your account to see your listings,sell items and more.",
            style: MyTextStyles.font14BrownRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          MaterialButton(
            color: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.login);
            },
            child: Text("Sign In", style: MyTextStyles.font16WhiteBold),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
