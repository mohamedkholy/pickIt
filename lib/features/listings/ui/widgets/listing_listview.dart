import 'package:flutter/material.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/listings/ui/widgets/listing_widget.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ListingListView extends StatefulWidget {
  final List<Item> items;
  final ListingStatus status;
  const ListingListView({super.key, required this.items, required this.status});

  @override
  State<ListingListView> createState() => _ListingListViewState();
}

class _ListingListViewState extends State<ListingListView> {
  late final List<Item> items;

  @override
  void initState() {
    filterByStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListingWidget(item: items[index]);
          },
        )
        : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                color: MyColors(context).primaryColorDark,
                size: 26,
              ),
              Text(
                "No ${widget.status.name} items was found",
                style: MyTextStyles(context).font14BrownBold,
              ),
            ],
          ),
        );
  }

  void filterByStatus() {
    switch (widget.status) {
      case ListingStatus.active:
        items =
            widget.items
                .where((e) => e.status == ListingStatus.active)
                .toList();
      case ListingStatus.inactive:
        items =
            widget.items
                .where((e) => e.status == ListingStatus.inactive)
                .toList();
      case ListingStatus.sold:
        items =
            widget.items.where((e) => e.status == ListingStatus.sold).toList();
    }
  }
}
