import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in", style: MyTextStyles.font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!_isValidEmail(value)) {
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
                    if (!_isValidPassword(value)) {
                      return "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character";
                    }
                    return null;
                  },
                  controller: _passwordController,
                  maxLines: 1,
                  hint: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forgot password?",
                    style: MyTextStyles.font14BrownRegular,
                  ),
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
                  child: Text("Log in", style: MyTextStyles.font16WhiteBold),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?",
                          style: MyTextStyles.font14BrownRegular,
                        ),
                        TextSpan(
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, Routes.signup);
                                },
                          text: " Sign up",
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
                            "Login with Google",
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
                            "Login with Facebook",
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

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
