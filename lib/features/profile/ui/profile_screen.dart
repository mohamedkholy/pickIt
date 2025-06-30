import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/not_signed_in_widget.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';
import 'package:pickit/features/profile/logic/profile_cubit.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';
import 'package:pickit/features/profile/ui/widgets/listings_item.dart';
import 'package:pickit/features/profile/ui/widgets/profile_options_item.dart';
import 'package:pickit/features/profile/ui/widgets/profile_picture.dart';
import 'package:pickit/features/main/logic/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit = context.read();

  @override
  void initState() {
    super.initState();
    _profileCubit.isSignedIn();
    _profileCubit.checkNotificationsState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UploadProfilePicError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: MyTextStyles(context).font18BlackBold),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProfileCubit, ProfileState>(
                    buildWhen:
                        (previous, current) =>
                            current is SignedIn || current is NotSignedIn,
                    builder: (context, state) {
                      if (state is SignedIn) {
                        return Column(
                          children: [
                            const ProfilePicture(),
                            SizedBox(height: 16.h),
                            Text(
                              state.user.displayName ?? "No Name",
                              style: MyTextStyles(context).font22BlackBold,
                            ),
                            Text(
                              state.user.email ?? "No Email",
                              style: MyTextStyles(context).font16BrownRegular,
                            ),
                            SizedBox(height: 32.h),
                          ],
                        );
                      }
                      if (state is NotSignedIn) {
                        return const NotSignedInWidget();
                      }
                      return Container();
                    },
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen:
                            (previous, current) =>
                                current is ListingsLoded ||
                                current is ListingsLoding ||
                                current is ListingsLodingError ||
                                current is NotSignedIn,
                        builder: (context, state) {
                          if (state is NotSignedIn) {
                            return Container();
                          }
                          if (state is ListingsLoding) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: MyColors(context).primaryColor,
                              ),
                            );
                          }
                          if (state is ListingsLodingError) {
                            return Center(
                              child: Text(
                                "Loading listings failed!",
                                style: MyTextStyles(context).font14MediumBlack,
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Listings",
                                style: MyTextStyles(context).font18BlackBold,
                              ),
                              SizedBox(height: 16.h),
                              ListingsItem(
                                items: _profileCubit.items,
                                icon: Icons.format_list_bulleted,
                                status: ListingStatus.active,
                              ),
                              ListingsItem(
                                items: _profileCubit.items,
                                icon: Icons.done,

                                status: ListingStatus.sold,
                              ),
                              ListingsItem(
                                items: _profileCubit.items,
                                icon: Icons.clear,
                                status: ListingStatus.inactive,
                              ),
                              Divider(
                                color: MyColors(context).secondaryColor,
                                thickness: 1.h,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ProfileOptionsItem(
                            onTap: null,
                            icon: Icons.settings_outlined,
                            text: "Dark mode",
                          ),
                          Switch(
                            value: context.watch<ThemeCubit>().isDarkMode,
                            onChanged: (value) {
                              context.read<ThemeCubit>().toogleDarkMode();
                            },
                          ),
                        ],
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen:
                            (previous, current) =>
                                current is NotificationsState,
                        builder: (context, state) {
                          if (state is! NotificationsState) {
                            return Container();
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ProfileOptionsItem(
                                onTap: null,
                                icon: Icons.notifications_outlined,
                                text: "Notifications",
                              ),
                              Switch(
                                value: state.notificationsOn,
                                onChanged: (value) {
                                  _profileCubit.toogleNotifications(value);
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      ProfileOptionsItem(
                        onTap: () {
                          _profileCubit.openHelpCenter();
                        },
                        icon: Icons.help_outline_outlined,
                        text: "Help Center",
                      ),
                      ProfileOptionsItem(
                        onTap: () {
                          _profileCubit.openPolicy();
                        },
                        icon: Icons.policy_outlined,
                        text: "Policy",
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        buildWhen:
                            (previous, current) =>
                                current is SignedIn || current is NotSignedIn,
                        builder: (context, state) {
                          if (state is SignedIn) {
                            return ProfileOptionsItem(
                              onTap: () {
                                _profileCubit.signOut();
                                context.read<MainCubit>().rebuildIndexedStack();
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
      ),
    );
  }
}
