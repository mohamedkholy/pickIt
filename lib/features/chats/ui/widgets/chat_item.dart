import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.chat),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(56.r),
              child: Image.asset(
                Assets.assetsImagesPngProfile,
                width: 56.r,
                height: 56.r,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Doe", style: MyTextStyles.font16BlackBold),
                  Text(
                    "Deal! I can pick it up tomorrow afternoon. What's your address?",
                    style: MyTextStyles.font14BrownRegular,
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
