import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class DayWidget extends StatelessWidget {
  final DateTime timestamp;
  const DayWidget({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final isToday = timestamp.day == DateTime.now().day;
    final isYesterday = timestamp.day == DateTime.now().day - 1;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: MyColors(context).primaryColorDark,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Text(
          textAlign: TextAlign.center,
          isToday
              ? "Today"
              : isYesterday
              ? "Yesterday"
              : DateFormat("dd MMMM yyyy").format(timestamp),
          style: MyTextStyles(context).font14WhiteBold,
        ),
      ),
    );
  }
}
