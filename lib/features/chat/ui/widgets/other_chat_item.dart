import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class OtherChatItem extends StatelessWidget {
  const OtherChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
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
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Liam", style: MyTextStyles.font13BlackRegular),
                      SizedBox(width: 4.w),
                      Text("12:00", style: MyTextStyles.font13BrownRegular),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Hey there! I'm interested in the bikeyou're selling. Is it still available?",
                      style: MyTextStyles.font14BlackRegular,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
