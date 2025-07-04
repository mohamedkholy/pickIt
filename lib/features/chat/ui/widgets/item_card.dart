import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemDetails, arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColors(context).secondaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.photos.first,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            Text(item.title, style: MyTextStyles(context).font16BlackBold),
            const Spacer(),
            Text(
              "\$${item.price.toString()}",
              style: MyTextStyles(context).font16BlackBold,
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
