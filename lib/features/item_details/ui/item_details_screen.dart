import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_button.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Item Details", style: MyTextStyles.font18BlackBold),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 200.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    PageView.builder(
                      itemCount: widget.item.photos.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: widget.item.photos[index],
                          fit: BoxFit.cover,
                          width: 390.w,
                          height: 260.h,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 8.h),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: widget.item.photos.length,
                          effect: ScaleEffect(
                            dotWidth: 10.w,
                            dotHeight: 10.h,
                            dotColor: MyColors.secondaryColor,
                            activeDotColor: MyColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ), // optional horizontal padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      widget.item.title,
                      style: MyTextStyles.font22BlackBold,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      widget.item.description,
                      style: MyTextStyles.font16BlackRegular,
                    ),
                    SizedBox(height: 24.h),
                    Text("Price", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Text(
                      "\$${widget.item.price}",
                      style: MyTextStyles.font16BlackRegular,
                    ),
                    SizedBox(height: 24.h),
                    Text("Location", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Text(
                      widget.item.city,
                      style: MyTextStyles.font16BlackRegular,
                    ),
                    SizedBox(height: 24.h),
                    Text("Seller", style: MyTextStyles.font18BlackBold),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundImage:
                              widget.item.seller.userImageUrl != null
                                  ? CachedNetworkImageProvider(
                                    widget.item.seller.userImageUrl!,
                                  )
                                  : const AssetImage(
                                    Assets.assetsImagesPngProfileAvatar,
                                  ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          widget.item.seller.userName,
                          style: MyTextStyles.font16BlackBold,
                        ),
                        const Spacer(),
                        if (FirebaseAuth.instance.currentUser?.uid !=
                            widget.item.seller.userId)
                          MyButton(
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser != null) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.chat,
                                  arguments: Chat(
                                    id:
                                        "${FirebaseAuth.instance.currentUser!.uid}-${widget.item.id}",
                                    item: widget.item,
                                    user: widget.item.seller,
                                  ),
                                );
                              } else {
                                Navigator.pushNamed(context, Routes.login);
                              }
                            },
                            text: "Message",
                          ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
