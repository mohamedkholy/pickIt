import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/ui/widgets/sell_item.dart';

class BrowseScreen extends StatelessWidget {
  final List<String> categories = [
    "All",
    "Furniture",
    "Electronics",
    "Clothing",
    "Books",
    "Sports Equipment",
    "Toys",
  ];
  BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsetsDirectional.only(end: 16.w),
        title: Text('Browse'),
        titleTextStyle: MyTextStyles.font18BlackBold,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Color(0xffF2E8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.assetsImagesSvgSearch,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        Color(0xff994D52),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("Search", style: MyTextStyles.font16BrownRegular),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      categories.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Color(0xffF2E8E8),
                        ),
                        margin: EdgeInsetsDirectional.only(end: 12.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          categories[index],
                          style: MyTextStyles.font14MediumBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return SellItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
