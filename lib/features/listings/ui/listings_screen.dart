import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/listings/logic/listings_cubit.dart';
import 'package:pickit/features/listings/logic/listings_state.dart';
import 'package:pickit/features/listings/ui/widgets/listing_listview.dart';
import 'package:pickit/features/listings/ui/widgets/listing_widget.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ListingsScreen extends StatefulWidget {
  final ListingStatus listing;
  final List<Item> items;
  const ListingsScreen({super.key, required this.listing, required this.items});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late final ListingsCubit _listingsCubit = context.read<ListingsCubit>();

  @override
  void initState() {
    _listingsCubit.initState(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectInitialIndex(widget.listing),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Listings", style: MyTextStyles(context).font18BlackBold),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColors(context).secondaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    overlayColor: WidgetStatePropertyAll(
                      MyColors(context).secondaryColor,
                    ),
                    indicatorColor: MyColors(context).primaryColorDark,
                    labelColor: MyColors(context).primaryColorDark,
                    unselectedLabelColor: MyColors(context).whiteText,
                    labelStyle: MyTextStyles(context).font16BlackBold,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(child: Text("Active")),
                      Tab(child: Text("Inactive")),
                      Tab(child: Text("Sold")),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocConsumer<ListingsCubit, ListingsState>(
                    listener: (context, state) {
                      if (state is ListingsError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            current is ListingsLoading ||
                            current is ListingsLoaded,
                    builder: (context, state) {
                      if (state is ListingsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is ListingsLoaded) {
                        return TabBarView(
                          children: [
                            ListingListView(
                              items: state.listings,
                              status: ListingStatus.active,
                            ),
                            ListingListView(
                              items: state.listings,
                              status: ListingStatus.inactive,
                            ),
                            ListingListView(
                              items: state.listings,
                              status: ListingStatus.sold,
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _selectInitialIndex(ListingStatus listing) {
    return switch (listing) {
      ListingStatus.active => 0,
      ListingStatus.inactive => 1,
      ListingStatus.sold => 2,
    };
  }
}
