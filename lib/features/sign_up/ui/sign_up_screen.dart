import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/helpers/validators.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up", style: MyTextStyles.font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Form(
            child: Column(
              children: [
                MyTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!Validators.isValidEmail(value)) {    
                      return "Invalid email format";
                    }
                    return null;
                  },
                  controller: _emailController,
                  hint: "Email",
                ),
                SizedBox(height: 24.h),
                MyTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (!Validators.isValidPassword(value)) {
                      return "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character";
                    }
                    return null;
                  },
                  controller: _passwordController,
                  maxLines: 1,
                  hint: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 24.h),
                MyTextFormField(
                  controller: _confirmPasswordController,
                  hint: "Confirm password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password is required";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  maxLines: 1,
                  isPassword: true,
                ),
                SizedBox(height: 24.h),
                MaterialButton(
                  minWidth: double.infinity,
                  color: MyColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement login logic
                    }
                  },
                  child: Text("Sign up", style: MyTextStyles.font16WhiteBold),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: MyTextStyles.font14BrownRegular,
                        ),
                        TextSpan(
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                          text: " Log in",
                          style: MyTextStyles.font14BrownBold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(child: Divider(color: MyColors.primaryColorDark)),
                    SizedBox(width: 12.w),
                    Text("OR", style: MyTextStyles.font14BrownRegular),
                    SizedBox(width: 12.w),
                    Expanded(child: Divider(color: MyColors.primaryColorDark)),
                  ],
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primaryColorDark),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          Assets.assetsImagesSvgGoogle,
                          width: 24.r,
                          height: 24.r,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "Sign up with Google",
                            style: MyTextStyles.font14BrownBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primaryColorDark),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          Assets.assetsImagesSvgFacebook,
                          width: 24.r,
                          height: 24.r,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            "Sign up with Facebook",
                            style: MyTextStyles.font14BrownBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
