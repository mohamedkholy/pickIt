import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
  });
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors(context).primaryColorDark),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            SvgPicture.asset(iconPath, width: 24, height: 24),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(text, style: MyTextStyles(context).font14BrownBold),
            ),
          ],
        ),
      ),
    );
  }
}
