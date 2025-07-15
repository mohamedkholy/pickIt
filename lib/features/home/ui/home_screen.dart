import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/home/logic/home_cubit.dart';
import 'package:pickit/features/home/logic/home_state.dart';
import 'package:pickit/features/home/ui/widgets/category_item.dart';
import 'package:pickit/features/home/ui/widgets/featured_item.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
     context.read<HomeCubit>().getFeaturedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsetsDirectional.only(end: 16),
        title: const Text('PickIt'),
        titleTextStyle: MyTextStyles(context).font18BlackBold,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.search);
                  },
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: MyColors(context).secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.assetsImagesSvgSearch,
                          width: 24,
                          height: 24,
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
                const SizedBox(height: 20),
                Text("Featured", style: MyTextStyles(context).font22BlackBold),
                const SizedBox(height: 28),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return Center(
                          child: Row(
                            children: [
                              ...List.generate(
                                4,
                                (index) => Shimmer(
                                  color: MyColors(context).primaryColor,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[300],
                                    ),
                                    margin: const EdgeInsetsDirectional.only(
                                      end: 12,
                                    ),
                                    width: 240,
                                    height: 135,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is HomeLoaded) {
                        return Row(
                          children: [
                            ...state.items.map(
                              (item) => FeaturedItem(item: item),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),

                const SizedBox(height: 36),
                Text(
                  "Categories",
                  style: MyTextStyles(context).font22BlackBold,
                ),
                const SizedBox(height: 28),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                  ),
                  itemCount: 6,
                  itemBuilder:
                      (context, index) => Container(
                        margin: EdgeInsetsDirectional.only(
                          end: index % 2 == 0 ? 10 : 0,
                          bottom: 10,
                        ),
                        child: CategoryItem(index: index),
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
