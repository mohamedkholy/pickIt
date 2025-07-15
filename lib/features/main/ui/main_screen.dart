import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/di/dependency_injection.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/logic/browse_cubit.dart';
import 'package:pickit/features/browse/ui/browse_screen.dart';
import 'package:pickit/features/chats/logic/chats_cubit.dart';
import 'package:pickit/features/chats/ui/chats_screen.dart';
import 'package:pickit/features/home/logic/home_cubit.dart';
import 'package:pickit/features/home/ui/home_screen.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';
import 'package:pickit/features/main/logic/main_state.dart';
import 'package:pickit/features/post_item/logic/post_item_cubit.dart';
import 'package:pickit/features/post_item/ui/post_item_screen.dart';
import 'package:pickit/features/profile/logic/profile_cubit.dart';
import 'package:pickit/features/profile/ui/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final MainCubit _cubit = context.read<MainCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state.selectedIndex == 1) {
          setState(() {
            _selectedIndex = 1;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors(context).whiteText,
          unselectedItemColor: MyColors(context).primaryColorDark,
          selectedLabelStyle: MyTextStyles(context).font12MediumBlack,
          unselectedLabelStyle: MyTextStyles(context).font12MediumBlack
              .copyWith(color: MyColors(context).primaryColorDark),
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'browse'),
            BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sell'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: IndexedStack(
          key: _cubit.indexedStackKey,
          index: _selectedIndex,
          children: [
            BlocProvider(
              create: (context) => getIt<HomeCubit>(),
              child: const HomeScreen(),
            ),
            BlocProvider(
              create: (context) => getIt<BrowseCubit>(),
              child: BrowseScreen(
                key: ValueKey(_cubit.state.category),
                category: _cubit.state.category,
              ),
            ),
            BlocProvider(
              create: (context) => getIt<PostItemCubit>(),
              child: const PostItemScreen(),
            ),
            BlocProvider(
              create: (context) => getIt<ChatsCubit>(),
              child: const ChatsScreen(),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
              child: ProfileScreen(key: UniqueKey()),
            ),
          ],
        ),
      ),
    );
  }
}
