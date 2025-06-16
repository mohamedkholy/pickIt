import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_dropdown.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';

class PostItemScreen extends StatelessWidget {
  const PostItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post an Item", style: MyTextStyles.font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  hint: "What are you seeling",
                  controller: TextEditingController(),
                ),
                SizedBox(height: 24.h),
                MyTextFormField(
                  hint: "Price",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 24.h),
                MyDropdown(),
                SizedBox(height: 24.h),
                MyTextFormField(
                  hint: "Description",
                  controller: TextEditingController(),
                  maxLines: 5,
                ),
                SizedBox(height: 24.h),
                Text("Photos", style: MyTextStyles.font22BlackBold),
                SizedBox(height: 24.h),
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(8.r),
                    strokeWidth: 3.w,
                    dashPattern: [6.w, 6.w],
                    color: MyColors.secondaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 56.h,
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text("Add photos", style: MyTextStyles.font18BlackBold),
                        SizedBox(height: 8.h),
                        Text(
                          "Add photos to show the item's condition",
                          style: MyTextStyles.font14BlackRegular,
                        ),
                        SizedBox(height: 24.h),
                        MaterialButton(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          color: MyColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Add photos",
                            style: MyTextStyles.font14BlackBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                MaterialButton(
                  minWidth: double.infinity,
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: MyColors.primaryColor,
                  onPressed: () {},
                  child: Text("Post Item", style: MyTextStyles.font16WhiteBold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
