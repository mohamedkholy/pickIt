import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chat/logic/chat_cubit.dart';
import 'package:pickit/features/chat/logic/chat_state.dart';
import 'package:pickit/features/chat/ui/widgets/day_widget.dart';
import 'package:pickit/features/chat/ui/widgets/item_card.dart';
import 'package:pickit/features/chat/ui/widgets/my_chat_item.dart';
import 'package:pickit/features/chat/ui/widgets/other_chat_item.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late final ChatCubit _chatCubit = context.read<ChatCubit>();
  late final String currentUserId;
  late final bool isSeller;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _chatCubit.getMessages(widget.chat);
    _chatCubit.listenToChat(widget.chat);
    currentUserId = _chatCubit.getUserID();
    isSeller = widget.chat.item.seller.userId == currentUserId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        isSeller
                            ? MyColors.primaryColor
                            : MyColors.primaryColorDark,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  padding: EdgeInsets.all(5.r),
                ),
                SizedBox(width: 5.w),
                Text(
                  isSeller ? "Selling to" : "Buying from",
                  style: MyTextStyles.font14BrownBold,
                ),
              ],
            ),
            Text(
              widget.chat.user.userName,
              style: MyTextStyles.font18BlackBold,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              ItemCard(item: widget.chat.item),
              SizedBox(height: 16.h),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  buildWhen:
                      (previous, current) =>
                          current is ChatLoading ||
                          current is ChatMessagesLoaded ||
                          current is ChatMessagesError,
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      );
                    }
                    if (state is ChatMessagesError) {
                      return Center(child: Text(state.error));
                    }
                    if (state is ChatMessagesLoaded) {
                      if (state.messages.isEmpty) {
                        return const Center(child: Text("No messages yet"));
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                final isNewDay =
                                    index == state.messages.length - 1 ||
                                    state.messages[index].timestamp.day !=
                                        state.messages[index + 1].timestamp.day;
                                final message = state.messages[index];
                                return message.senderId == currentUserId
                                    ? MyChatItem(
                                      message: message,
                                      isNewDay: isNewDay,
                                    )
                                    : OtherChatItem(
                                      message: message,
                                      user: widget.chat.user,
                                      isNewDay: isNewDay,
                                    );
                              },
                            ),
                          ),
                          TextField(
                            controller: _messageController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: MyColors.primaryColorDark,
                                onPressed:
                                    _messageController.text.isNotEmpty
                                        ? () {
                                          _chatCubit.sendMessage(
                                            Message(
                                              id: "1",
                                              message: _messageController.text,
                                              senderId: currentUserId,
                                              timestamp: DateTime.now(),
                                            ),
                                            widget.chat,
                                          );
                                          _messageController.clear();
                                        }
                                        : null,
                                icon: const Icon(Icons.send),
                              ),
                              hintText: "Write a message...",
                              hintStyle: MyTextStyles.font16BrownRegular,
                              filled: true,
                              fillColor: Color(0xffF2E8E8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
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
