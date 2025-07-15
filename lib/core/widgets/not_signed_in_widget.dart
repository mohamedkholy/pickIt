import 'package:flutter/material.dart';

import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class NotSignedInWidget extends StatelessWidget {
  const NotSignedInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_pin_circle_rounded,
            size: 56,
            color: MyColors(context).primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            "You are not signed in",
            style: MyTextStyles(context).font18BlackBold,
          ),
          const SizedBox(height: 8),
          Text(
            "Sign in to your account to see your listings,sell items and more.",
            style: MyTextStyles(context).font14BrownRegular,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          MaterialButton(
            color: MyColors(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.login);
            },
            child: Text(
              "Sign In",
              style: MyTextStyles(context).font16WhiteBold,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
