import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/ui/widgets/sell_item.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/listings/logic/listings_cubit.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ListingWidget extends StatefulWidget {
  final Item item;
  const ListingWidget({super.key, required this.item});

  @override
  State<ListingWidget> createState() => _ListingWidgetState();
}

class _ListingWidgetState extends State<ListingWidget> {
  late final ListingsCubit _cubit = context.read();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          SellItem(item: widget.item),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    switch (widget.item.status) {
                      case ListingStatus.active:
                        _cubit.updateState(widget.item, ListingStatus.sold);
                      case ListingStatus.inactive:
                        _cubit.updateState(widget.item, ListingStatus.active);
                      case ListingStatus.sold:
                        _cubit.updateState(widget.item, ListingStatus.active);
                      case null:
                        throw UnimplementedError("widget.item.status is null");
                    }
                  },
                  icon: Icon(
                    widget.item.status == ListingStatus.active
                        ? Icons.attach_money_outlined
                        : Icons.check_circle,
                    size: 16,
                  ),
                  label: Text(switch (widget.item.status) {
                    ListingStatus.active => "Sold",
                    ListingStatus.inactive => "Active",
                    ListingStatus.sold => "Available",
                    null => "",
                  }, style: MyTextStyles(context).font14WhiteBold),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8),
              if (widget.item.status != ListingStatus.sold)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        widget.item.status == ListingStatus.active
                            ? () {
                              _cubit.updateState(
                                widget.item,
                                ListingStatus.inactive,
                              );
                            }
                            : widget.item.status == ListingStatus.inactive
                            ? () {
                              _cubit.updateState(
                                widget.item,
                                ListingStatus.sold,
                              );
                            }
                            : () {
                              _cubit.deleteItem(widget.item);
                            },
                    icon: Icon(
                      widget.item.status == ListingStatus.inactive
                          ? Icons.attach_money_outlined
                          : Icons.visibility_off,
                      size: 16,
                    ),
                    label: Text(
                      widget.item.status == ListingStatus.active
                          ? 'Inactive'
                          : "Sold",

                      style: MyTextStyles(context).font14WhiteBold,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _cubit.deleteItem(widget.item);
                  },
                  icon: Icon(Icons.delete, size: 16),
                  label: Text(
                    "Delete",
                    style: MyTextStyles(context).font14WhiteBold,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
