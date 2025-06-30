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
import 'package:pickit/features/login/logic/login_cubit.dart';
import 'package:pickit/features/login/logic/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final LoginCubit _loginCubit = context.read<LoginCubit>();
  final _invalidPasswordMessage =
      "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: _loginCubit,
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => PopScope(
                  canPop: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors(context).primaryColor,
                    ),
                  ),
                ),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.main,
            (route) => false,
          );
        }
        if (state is LoginFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Log in", style: MyTextStyles(context).font18BlackBold),
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
                        return _invalidPasswordMessage;
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
                      style: MyTextStyles(context).font14BrownRegular,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  MyButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginCubit.loginWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    text: "Log in",
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?",
                            style: MyTextStyles(context).font14BrownRegular,
                          ),
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, Routes.signup);
                                  },
                            text: " Sign up",
                            style: MyTextStyles(context).font14BrownBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: MyColors(context).primaryColorDark,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "OR",
                        style: MyTextStyles(context).font14BrownRegular,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Divider(
                          color: MyColors(context).primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  IconTextButton(
                    iconPath: Assets.assetsImagesSvgGoogle,
                    text: "Login with Google",
                    onTap: () {
                      _loginCubit.loginWithGoogle();
                    },
                  ),
                  SizedBox(height: 24.h),
                  IconTextButton(
                    iconPath: Assets.assetsImagesSvgFacebook,
                    text: "Login with Facebook",
                    onTap: () {},
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
