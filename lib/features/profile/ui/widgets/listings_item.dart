import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/routing/routes.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/profile/logic/profile_cubit.dart';

class ListingsItem extends StatelessWidget {
  final List<Item> items;
  const ListingsItem({
    super.key,
    required this.icon,
    required this.status,
    required this.items,
  });
  final IconData icon;
  final ListingStatus status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.listings,
          arguments: {"listing": status, "items": items},
        ).then((_) {
          if (context.mounted) {
            context.read<ProfileCubit>().getListings();
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColors(context).secondaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Icon(icon, size: 20),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status.name, style: MyTextStyles(context).font16BlackBold),
                Text(
                  "${items.where((e) => e.status == status).length}  Listings",
                  style: MyTextStyles(context).font14BrownRegular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
