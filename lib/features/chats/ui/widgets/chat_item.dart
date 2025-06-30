import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chats/data/models/chat.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  const ChatItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final isSeller =
        chat.item.seller.userId == FirebaseAuth.instance.currentUser!.uid;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.chat, arguments: chat),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors(context).white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 8.h,
          horizontal: 8.w,
        ),
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        isSeller
                            ? MyColors(context).primaryColor
                            : MyColors(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  padding: EdgeInsets.all(5.r),
                ),
                SizedBox(width: 5.w),
                Text(
                  isSeller ? "Selling" : "Buying",
                  style: MyTextStyles(context).font14BrownBold,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(56.r),
                        child: CachedNetworkImage(
                          imageUrl: chat.user.userImageUrl ?? "",
                          width: 50.r,
                          height: 50.r,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.user.userName,
                              style: MyTextStyles(context).font16BlackBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (chat.lastMessage != null)
                              Text(
                                chat.lastMessage!,
                                style: MyTextStyles(context).font14BrownRegular,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (chat.unreadMessages > 0)
                        Row(
                          children: [
                            SizedBox(width: 8.w),
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors(context).primaryColor,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              child: Text(
                                "${chat.unreadMessages}",
                                style: MyTextStyles(context).font14WhiteBold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: chat.item.photos.first,
                          width: 60.r,
                          height: 60.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        chat.item.title,
                        style: MyTextStyles(context).font14BrownBold,
                        overflow: TextOverflow.ellipsis,
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
