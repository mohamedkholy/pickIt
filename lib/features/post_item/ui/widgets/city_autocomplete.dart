import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';
import 'package:pickit/features/post_item/logic/post_item_cubit.dart';
import 'package:pickit/features/post_item/logic/post_item_state.dart';

class CityAutocomplete extends StatefulWidget {
  const CityAutocomplete({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<CityAutocomplete> createState() => _CityAutocompleteState();
}

class _CityAutocompleteState extends State<CityAutocomplete> {
  final List<String> cities = [
    "Tanta",
    "Cairo",
    "Alexandria",
    "Luxor",
    "Asyut",
    "Suez",
  ];
  late final PostItemCubit _postItemCubit = context.read<PostItemCubit>();
  TextEditingController? cityController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Autocomplete(
            displayStringForOption: (option) {
              return option.toString();
            },
            optionsBuilder: (textEditingValue) async {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }

              try {
                final placemarks = await GeocodingPlatform.instance!
                    .placemarkFromAddress(textEditingValue.text);

                final localities =
                    placemarks.map((e) => e.locality).map((e) => e!).toSet();

                return localities;
              } catch (e) {
                return const Iterable<String>.empty();
              }
            },
            onSelected: (option) {
              widget.controller.text = option.toString();
            },
            fieldViewBuilder: (
              context,
              textEditingController,
              focusNode,
              onFieldSubmitted,
            ) {
              cityController ??= textEditingController;
              return MyTextFormField(
                focusNode: focusNode,
                controller: cityController!,
                hint: "City",
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    widget.controller.text = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "City is required";
                  }
                  return null;
                },
              );
            },
          ),
        ),
        BlocConsumer<PostItemCubit, PostItemState>(
          listener: (context, state) {
            if (state is CityFetched) {
              widget.controller.text = state.city;
              cityController?.text = state.city;
            }
            if (state is CityFetchingError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is FetchingCity) {
              return Padding(
                padding: EdgeInsets.all(8.r),
                child: CircularProgressIndicator(
                  color: MyColors(context).primaryColor,
                ),
              );
            }
            return IconButton(
              onPressed: () {
                _postItemCubit.getCity(context);
              },
              icon: Icon(
                Icons.location_on_rounded,
                size: 32.r,
                color: MyColors(context).primaryColor,
              ),
            );
          },
        ),
      ],
    );
  }
}
