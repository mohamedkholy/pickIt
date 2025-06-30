import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class MyDropdown extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  const MyDropdown({super.key, required this.items, required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textStyle: MyTextStyles(context).font16BlackRegular,
      hintText: "Category",
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: MyTextStyles(context).font16BrownRegular,
        fillColor: MyColors(context).secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      width: double.infinity,
      onSelected: (value) {
        controller.text = value ?? "";
      },
      dropdownMenuEntries: [
        for (var item in items) DropdownMenuEntry(value: item, label: item),
      ],
    );
  }
}
