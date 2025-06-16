import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/profile/logic/profile_cubit.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';
import 'package:pickit/features/profile/ui/widgets/listings_item.dart';
import 'package:pickit/features/profile/ui/widgets/profile_options_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit profileCubit = context.read<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    profileCubit.isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: MyTextStyles.font18BlackBold),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is SignedIn) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(128.r),
                            child: Image.asset(
                              width: 128.w,
                              height: 128.h,
                              Assets.assetsImagesPngProfile,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text("John Doe", style: MyTextStyles.font22BlackBold),
                          Text(
                            "john.doe@example.com",
                            style: MyTextStyles.font16BrownRegular,
                          ),
                          SizedBox(height: 32.h),
                        ],
                      );
                    }
                    if (state is NotSignedIn) {
                      return Column(
                        children: [
                          Icon(
                            Icons.person_pin_circle_rounded,
                            size: 56.dg,
                            color: MyColors.primaryColor,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "You are not signed in",
                            style: MyTextStyles.font18BlackBold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Sign in to your account to see your listings,sell items and more.",
                            style: MyTextStyles.font14BrownRegular,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          MaterialButton(
                            color: MyColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            onPressed: () {
                              profileCubit.signIn();
                            },
                            child: Text(
                              "Sign In / Create Account",
                              style: MyTextStyles.font16WhiteBold,
                            ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      );
                    }
                    return Container();
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is SignedIn) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Listings",
                                style: MyTextStyles.font18BlackBold,
                              ),
                              SizedBox(height: 16.h),

                              ListingsItem(
                                icon: Icons.format_list_bulleted,
                                listingsCount: 2,
                                status: "Active",
                              ),

                              ListingsItem(
                                icon: Icons.done,
                                listingsCount: 3,
                                status: "Sold",
                              ),
                              ListingsItem(
                                icon: Icons.clear,
                                listingsCount: 3,
                                status: "InActive",
                              ),
                              Divider(
                                color: MyColors.secondaryColor,
                                thickness: 1.h,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    ProfileOptionsItem(
                      onTap: () {},
                      icon: Icons.settings_outlined,
                      text: "Settings",
                    ),
                    ProfileOptionsItem(
                      onTap: () {},
                      icon: Icons.favorite_border_outlined,
                      text: "Favorites",
                    ),
                    ProfileOptionsItem(
                      onTap: () {},
                      icon: Icons.notifications_outlined,
                      text: "Notifications",
                    ),
                    ProfileOptionsItem(
                      onTap: () {},
                      icon: Icons.help_outline_outlined,
                      text: "Help Center",
                    ),
                    ProfileOptionsItem(
                      onTap: () {},
                      icon: Icons.policy_outlined,
                      text: "Policy",
                    ),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is SignedIn) {
                          return ProfileOptionsItem(
                            onTap: () {
                              profileCubit.signOut();
                            },
                            icon: Icons.logout,
                            text: "Logout",
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
