import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chats/ui/widgets/chat_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats", style: MyTextStyles.font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) => ChatItem(),
          ),
        ),
      ),
    );
  }
}
