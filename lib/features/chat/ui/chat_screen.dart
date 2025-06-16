import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';
import 'package:pickit/features/chat/ui/widgets/my_chat_item.dart';
import 'package:pickit/features/chat/ui/widgets/other_chat_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liam", style: MyTextStyles.font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder:
                      (context, index) =>
                          index.isOdd ? MyChatItem() : OtherChatItem(),
                ),
              ),

              MyTextFormField(
                hint: "Write a message...",
                controller: TextEditingController(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
