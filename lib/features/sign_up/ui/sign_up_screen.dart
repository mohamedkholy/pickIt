import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/helpers/validators.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/icon_text_button.dart';
import 'package:pickit/core/widgets/my_button.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';
import 'package:pickit/features/sign_up/logic/sign_up_cubit.dart';
import 'package:pickit/features/sign_up/logic/sign_up_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final SignUpCubit _signUpCubit = context.read<SignUpCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      bloc: _signUpCubit,
      listener: (context, state) {
        if (state is SignUpLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const PopScope(
                  canPop: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  ),
                ),
          );
        } else if (state is SignUpSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.main,
            (route) => false,
          );
        } else if (state is SignUpFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign up", style: MyTextStyles.font18BlackBold),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      if (value.length < 5 || value.length > 20) {
                        return "Name must be at least 5 characters long";
                      }
                      return null;
                    },
                    hint: "Name",
                  ),
                  SizedBox(height: 24.h),
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
                  MyButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpCubit.signUpWithEmailAndPassword(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                    text: "Sign up",
                  ),
                  SizedBox(height: 12.h),
                  Align(
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
                      const Expanded(
                        child: Divider(color: MyColors.primaryColorDark),
                      ),
                      SizedBox(width: 12.w),
                      Text("OR", style: MyTextStyles.font14BrownRegular),
                      SizedBox(width: 12.w),
                      const Expanded(
                        child: Divider(color: MyColors.primaryColorDark),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  IconTextButton(
                    iconPath: Assets.assetsImagesSvgGoogle,
                    text: "Sign up with Google",
                    onTap: () {
                      _signUpCubit.signUpWithGoogle();
                    },
                  ),
                  SizedBox(height: 24.h),
                  IconTextButton(
                    iconPath: Assets.assetsImagesSvgFacebook,
                    text: "Sign up with Facebook",
                    onTap: () {
                      _signUpCubit.signUpWithFacebook();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
