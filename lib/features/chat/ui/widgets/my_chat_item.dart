import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chat/ui/widgets/day_widget.dart';

class MyChatItem extends StatelessWidget {
  final Message message;
  final bool isNewDay;
  const MyChatItem({super.key, required this.message, required this.isNewDay});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            if (isNewDay) DayWidget(timestamp: message.timestamp),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(message.timestamp),
                            style: MyTextStyles(context).font13BrownRegular,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "You",
                            style: MyTextStyles(context).font13BlackRegular,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          message.message,
                          style: MyTextStyles(context).font14BlackRegular,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      imageUrl:
                          FirebaseAuth.instance.currentUser!.photoURL ??
                          Assets.assetsImagesPngProfileAvatar,
                      width: 40,
                      height: 40,
                    ),
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
