import 'package:flutter/material.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class NoInternetLayout extends StatelessWidget {
  const NoInternetLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 100,
                color: MyColors(context).primaryColorDark,
              ),
              const SizedBox(height: 24),
              Text(
                'No Internet Connection',
                style: MyTextStyles(context).font20WhiteBold,
              ),
              const SizedBox(height: 12),
              Text(
                'Please check your network settings.',
                textAlign: TextAlign.center,
                style: MyTextStyles(context).font14BrownRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
