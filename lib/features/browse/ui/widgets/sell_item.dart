import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/item_details/ui/item_details.dart';

class SellItem extends StatelessWidget {
  const SellItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetails()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Clothing",
                        style: MyTextStyles.font14BrownRegular,
                      ),
                      TextSpan(
                        text: " . Tanta",
                        style: MyTextStyles.font14BrownRegular,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Wireless Headphones",
                  style: MyTextStyles.font16BlackBold,
                ),
                SizedBox(height: 4.h),
                Text(r"$80", style: MyTextStyles.font14BrownRegular),
              ],
            ),
            Image.asset(
              fit: BoxFit.cover,
              Assets.assetsImagesPngLivingRoom,
              width: 130.w,
              height: 70.h,
            ),
          ],
        ),
      ),
    );
  }
}
