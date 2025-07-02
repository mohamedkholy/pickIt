import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class FeaturedItem extends StatelessWidget {
  final Item item;
  const FeaturedItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetails, arguments: item);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(end: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.photos.first,
                fit: BoxFit.cover,
                width: 240.w,
                height: 135.h,
              ),
            ),
            SizedBox(height: 10.h),
            Text(item.title, style: MyTextStyles(context).font16BlackMedium),
          ],
        ),
      ),
    );
  }
}
