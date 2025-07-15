import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickit/core/constants/assets.dart';

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
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: const EdgeInsets.all(5),
                ),
                const SizedBox(width: 5),
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
                        borderRadius: BorderRadius.circular(56),
                        child:
                            chat.user.userImageUrl != null
                                ? CachedNetworkImage(
                                  imageUrl: chat.user.userImageUrl!,

                                  width: 50,
                                  height: 50,
                                )
                                : Image.asset(
                                  Assets.assetsImagesPngProfileAvatar,
                                  width: 50,
                                  height: 50,
                                ),
                      ),
                      const SizedBox(width: 16),
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
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors(context).primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Text(
                                "${chat.unreadMessages}",
                                style: MyTextStyles(context).font14WhiteBold,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: chat.item.photos.first,
                          width: 60,
                          height: 60,
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
