import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chat/ui/widgets/day_widget.dart';
import 'package:pickit/features/post_item/data/models/user.dart';

class OtherChatItem extends StatelessWidget {
  final Message message;
  final User user;
  final bool isNewDay;
  const OtherChatItem({
    super.key,
    required this.message,
    required this.user,
    required this.isNewDay,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Column(
          children: [
            if (isNewDay) DayWidget(timestamp: message.timestamp),
            Row(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          user.userImageUrl ?? Assets.assetsImagesPngProfileAvatar,
                      width: 40.r,
                      height: 40.r,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.userName,
                            style: MyTextStyles.font13BlackRegular,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            DateFormat('HH:mm').format(message.timestamp),
                            style: MyTextStyles.font13BrownRegular,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors.secondaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          message.message,
                          style: MyTextStyles.font14BlackRegular,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
