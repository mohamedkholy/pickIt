import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class SellItem extends StatelessWidget {
  final Item item;
  const SellItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetails, arguments: item);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: item.category,
                          style: MyTextStyles.font14BrownRegular,
                        ),
                        TextSpan(
                          text: " . ${item.city}",
                          style: MyTextStyles.font14BrownRegular,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.title,
                    style: MyTextStyles.font16BlackBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "\$${item.price}",
                    style: MyTextStyles.font14BrownRegular,
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.photos.first,
                fit: BoxFit.cover,
                width: 130.w,
                height: 70.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
