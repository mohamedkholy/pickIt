import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final Map<String, String> categories = {
    "Furniture": Assets.assetsImagesPngFurniture,
    "Electronics": Assets.assetsImagesPngElectronics,
    "Clothing": Assets.assetsImagesPngClothing,
    "Books": Assets.assetsImagesPngBooks,
    "Sports Equipment": Assets.assetsImagesPngSportsEquipment,
    "Toys": Assets.assetsImagesPngToys,
  };
  CategoryItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE8D1D1)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Image.asset(
            categories.values.toList()[index],
            width: 40.w,
            height: 40.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              categories.keys.toList()[index],
              style: MyTextStyles.font16BlackBold,
            ),
          ),
        ],
      ),
    );
  }
}
