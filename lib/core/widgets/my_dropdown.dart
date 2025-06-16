import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class MyDropdown extends StatelessWidget {
  final List<String> categories = const [
    "Furniture",
    "Electronics",
    "Clothing",
    "Books",
    "Sports Equipment",
    "Toys",
  ];
  const MyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textStyle: MyTextStyles.font16BlackRegular,
      hintText: "Category",
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: MyTextStyles.font16BrownRegular,
        fillColor: Color(0xffF2E8E8),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
      width: double.infinity,
      onSelected: (value) {},
      dropdownMenuEntries: [
        for (var category in categories)
          DropdownMenuEntry(value: category, label: category),
      ],
    );
  }
}
