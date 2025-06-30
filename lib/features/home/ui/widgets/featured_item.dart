import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.assetsImagesPngLivingRoom,
            fit: BoxFit.cover,
            width: 240.w,
            height: 135.h,
          ),
          SizedBox(height: 10.h),
          Text("Living Room", style: MyTextStyles(context).font16BlackMedium),
        ],
      ),
    );
  }
}
