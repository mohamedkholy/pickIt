import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class ListingsItem extends StatelessWidget {
  const ListingsItem({
    super.key,
    required this.icon,
    required this.listingsCount,
    required this.status,
  });
  final IconData icon;
  final int listingsCount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: MyColors.secondaryColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            child: Icon(icon, size: 20.dg),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(status, style: MyTextStyles.font16BlackBold),
              Text(
                "$listingsCount listings",
                style: MyTextStyles.font14BrownRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
