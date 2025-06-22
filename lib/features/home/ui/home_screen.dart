import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/home/ui/widgets/category_item.dart';
import 'package:pickit/features/home/ui/widgets/featured_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsetsDirectional.only(end: 16.w),
        title: const Text('PickIt'),
        titleTextStyle: MyTextStyles.font18BlackBold,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2E8E8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.assetsImagesSvgSearch,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: const ColorFilter.mode(
                          Color(0xff994D52),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Search", style: MyTextStyles.font16BrownRegular),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text("Featured", style: MyTextStyles.font22BlackBold),
                SizedBox(height: 28.h),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FeaturedItem(),
                      FeaturedItem(),
                      FeaturedItem(),
                      FeaturedItem(),
                    ],
                  ),
                ),
                SizedBox(height: 36.h),
                Text("Categories", style: MyTextStyles.font22BlackBold),
                SizedBox(height: 28.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                  ),
                  itemCount: 6,
                  itemBuilder:
                      (context, index) => Container(
                        margin: EdgeInsetsDirectional.only(
                          end: index % 2 == 0 ? 10.w : 0,
                          bottom: 10.h,
                        ),
                        child: CategoryItem(index: index),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
