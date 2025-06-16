import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: MyTextStyles.font18BlackBold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(128.r),
                  child: Image.asset(
                    width: 128.w,
                    height: 128.h,
                    Assets.assetsImagesPngProfile,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                Text("John Doe", style: MyTextStyles.font22BlackBold),
                Text(
                  "john.doe@example.com",
                  style: MyTextStyles.font16BrownRegular,
                ),
                SizedBox(height: 32.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Listings", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w,
                          ),
                          child: Icon(Icons.format_list_bulleted, size: 20.dg),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Active", style: MyTextStyles.font16BlackBold),
                            Text(
                              "12 listings",
                              style: MyTextStyles.font14BrownRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w,
                          ),
                          child: Icon(Icons.done, size: 20.dg),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sold", style: MyTextStyles.font16BlackBold),
                            Text(
                              "3 listings",
                              style: MyTextStyles.font14BrownRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w,
                          ),
                          child: Icon(Icons.clear, size: 20.dg),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Inactive",
                              style: MyTextStyles.font16BlackBold,
                            ),
                            Text(
                              "2 listings",
                              style: MyTextStyles.font14BrownRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text("Settings", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 20.dg,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Notifications",
                          style: MyTextStyles.font16BlackRegular,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: Icon(Icons.help_outline_outlined, size: 20.dg),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Help Center",
                          style: MyTextStyles.font16BlackRegular,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: MyColors.secondaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: Icon(Icons.policy_outlined, size: 20.dg),
                        ),
                        SizedBox(width: 16.w),
                        Text("Policy", style: MyTextStyles.font16BlackRegular),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
