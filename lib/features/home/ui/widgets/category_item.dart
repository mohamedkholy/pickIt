import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final Map<String, String> categories = {
    "Furniture": Assets.assetsImagesPngFurniture,
    "Electronics": Assets.assetsImagesPngElectronics,
    "Clothing": Assets.assetsImagesPngClothing,
    "Books": Assets.assetsImagesPngBooks,
    "Properties": Assets.assetsImagesPngProperties,
    "Toys": Assets.assetsImagesPngToys,
  };
  CategoryItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MainCubit>().moveToBrowse(categories.keys.toList()[index]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE8D1D1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              categories.values.toList()[index],
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                categories.keys.toList()[index],
                maxLines: 1,
                style: MyTextStyles(context).font16BlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
