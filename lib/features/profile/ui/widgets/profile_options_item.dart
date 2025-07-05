import 'package:flutter/material.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class ProfileOptionsItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileOptionsItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors(context).secondaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(icon, size: 20),
            ),
            SizedBox(width: 16),
            Text(text, style: MyTextStyles(context).font16BlackRegular),
          ],
        ),
      ),
    );
  }
}
