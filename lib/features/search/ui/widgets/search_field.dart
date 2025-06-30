import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/search/logic/search_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final SearchCubit cubit = context.read();
  final Debouncer _debouncer = Debouncer();
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _editingController,
      textInputAction: TextInputAction.search,
      onChanged: _handleTextFieldChange,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: null,
          icon: Icon(Icons.search, color: MyColors(context).primaryColorDark),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _editingController.clear();
            _handleTextFieldChange(null);
          },
          icon: Icon(Icons.clear, color: MyColors(context).primaryColorDark),
        ),
        hintText: "Search now...",
        hintStyle: MyTextStyles(context).font16BrownRegular,
        filled: true,
        fillColor: MyColors(context).secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _handleTextFieldChange(String? value) {
    const duration = Duration(milliseconds: 700);
    _debouncer.debounce(
      duration: duration,
      onDebounce: () {
        cubit.search(_editingController.text);
      },
    );
  }
}
