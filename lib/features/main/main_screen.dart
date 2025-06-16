import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/browse/ui/browse_screen.dart';
import 'package:pickit/features/chats/ui/chats_screen.dart';
import 'package:pickit/features/home/ui/home_screen.dart';
import 'package:pickit/features/item_details/ui/item_details.dart';
import 'package:pickit/features/post_item/ui/post_item_screen.dart';
import 'package:pickit/features/profile/ui/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24.h,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xff994D52),
        selectedLabelStyle: MyTextStyles.font12MediumBlack,
        unselectedLabelStyle: MyTextStyles.font12MediumBlack.copyWith(
          color: Color(0xff994D52),
        ),
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'browse'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sell'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          BrowseScreen(),
          PostItemScreen(),
          ChatsScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
