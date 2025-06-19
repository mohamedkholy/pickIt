import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_button.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Item Details", style: MyTextStyles.font18BlackBold),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 200.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  fit: BoxFit.cover,
                  Assets.assetsImagesPngLivingRoom,
                  width: 390.w,
                  height: 260.h,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ), // optional horizontal padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text("Used Bicycle", style: MyTextStyles.font22BlackBold),
                    SizedBox(height: 16.h),
                    Text(
                      "This bicycle is in good condition and has been used for 2 years. It's perfect for city commuting or leisurely rides.",
                      style: MyTextStyles.font16BlackRegular,
                    ),
                    SizedBox(height: 24.h),
                    Text("Price", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Text("\$100", style: MyTextStyles.font16BlackRegular),
                    SizedBox(height: 24.h),
                    Text("Location", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Text(
                      "Cairo, Egypt",
                      style: MyTextStyles.font16BlackRegular,
                    ),
                    SizedBox(height: 24.h),
                    Text("Seller", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundImage: AssetImage(
                            Assets.assetsImagesPngUser,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: MyTextStyles.font16BlackBold,
                            ),
                            Text(
                              "Joined 2021",
                              style: MyTextStyles.font14BrownRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(onPressed: () {}, text: "Message"),
                        MyButton(
                          onPressed: () {},
                          text: "Buy Now",
                          textStyle: MyTextStyles.font16BlackBold,
                          color: MyColors.secondaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
