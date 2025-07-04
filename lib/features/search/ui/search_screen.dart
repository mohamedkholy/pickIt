import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/ui/widgets/sell_item.dart';
import 'package:pickit/features/search/logic/search_cubit.dart';
import 'package:pickit/features/search/logic/search_state.dart';
import 'package:pickit/features/search/ui/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCubit _cubit = context.read();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: MyTextStyles(context).font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            children: [
              const SearchField(),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is InitialState) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search,
                              color: MyColors(context).primaryColorDark,
                              size: 26.dg,
                            ),
                            Text(
                              "Start typing to search for items.",
                              style: MyTextStyles(context).font14BrownBold,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is Searching) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColors(context).primaryColor,
                        ),
                      );
                    }
                    if (state is SearchError) {
                      return Center(child: Text(state.error));
                    }
                    if (state is Searched) {
                      return state.items.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.priority_high,
                                  color: MyColors(context).primaryColorDark,
                                  size: 26.dg,
                                ),
                                Text(
                                  "No results for \"${_cubit.query}\"",
                                  style: MyTextStyles(context).font14BrownBold,
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              return SellItem(item: state.items[index]);
                            },
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
    );
  }
}
