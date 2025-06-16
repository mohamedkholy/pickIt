import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class MyChatItem extends StatelessWidget {
  const MyChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("12:00", style: MyTextStyles.font13BrownRegular),
                      SizedBox(width: 4.w),
                      Text("You", style: MyTextStyles.font13BlackRegular),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Hi Liam, yes it is! It's in great condition and ready for a new owner.",
                      style: MyTextStyles.font14BlackRegular,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: Image.asset(
                  Assets.assetsImagesPngProfile,
                  width: 40.r,
                  height: 40.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
