import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/logic/browse_cubit.dart';
import 'package:pickit/features/browse/logic/browse_state.dart';
import 'package:pickit/features/browse/ui/widgets/sell_item.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';

class BrowseScreen extends StatefulWidget {
  final String? category;
  const BrowseScreen({super.key, this.category});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late final BrowseCubit cubit = context.read<BrowseCubit>();
  late String selectedCategory = widget.category ?? "All";
  final ScrollController _scrollController = ScrollController();

  final List<String> categories = [
    "All",
    "Furniture",
    "Electronics",
    "Clothing",
    "Books",
    "Properties",
    "Toys",
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category ?? "All";
    cubit.getItems(
      category: selectedCategory == "All" ? null : selectedCategory,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(
        (categories.indexOf(selectedCategory) + 1) /
            categories.length *
            _scrollController.position.maxScrollExtent,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsetsDirectional.only(end: 16.w),
        title: const Text('Browse'),
        titleTextStyle: MyTextStyles(context).font18BlackBold,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.search);
                },
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: MyColors(context).secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.assetsImagesSvgSearch,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          MyColors(context).primaryColorDark,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search",
                        style: MyTextStyles(context).font16BrownRegular,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      categories.length,
                      (index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                          cubit.getItems(
                            category:
                                selectedCategory == "All"
                                    ? null
                                    : selectedCategory,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color:
                                selectedCategory == categories[index]
                                    ? MyColors(context).primaryColorDark
                                    : MyColors(context).secondaryColor,
                          ),
                          margin: EdgeInsetsDirectional.only(end: 12.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          child: Text(
                            categories[index],
                            style: MyTextStyles(context).font14MediumBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: BlocBuilder<BrowseCubit, BrowseState>(
                  builder: (context, state) {
                    if (state is BrowseLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColors(context).primaryColor,
                        ),
                      );
                    }
                    if (state is BrowseError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.priority_high,
                              color: MyColors(context).primaryColorDark,
                              size: 26.dg,
                            ),
                            Text(
                              state.message,
                              style: MyTextStyles(context).font14BrownBold,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is BrowseSuccess) {
                      return RefreshIndicator(
                        color: MyColors(context).primaryColor,
                        onRefresh: () async {
                          await cubit.getItems();
                        },
                        child: ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            if (state.items[index].status ==
                                ListingStatus.active) {
                              return SellItem(item: state.items[index]);
                            }
                            return Container();
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
