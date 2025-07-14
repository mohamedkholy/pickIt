import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chat/logic/chat_cubit.dart';
import 'package:pickit/features/chat/logic/chat_state.dart';
import 'package:pickit/features/chat/ui/widgets/item_card.dart';
import 'package:pickit/features/chat/ui/widgets/my_chat_item.dart';
import 'package:pickit/features/chat/ui/widgets/other_chat_item.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/chats/logic/chats_cubit.dart';
import 'package:pickit/features/main/logic/main_cubit.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late final ChatCubit _chatCubit = context.read();
  late final MainCubit _mainCubit = context.read();
  late final String currentUserId;
  late final bool isSeller;

  @override
  void dispose() {
    _mainCubit.currentChatUserId = null;
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _mainCubit.currentChatUserId = widget.chat.user.userId;
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
                            ? MyColors(context).primaryColor
                            : MyColors(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                SizedBox(width: 5),
                Text(
                  isSeller ? "Selling to" : "Buying from",
                  style: MyTextStyles(context).font14BrownBold,
                ),
              ],
            ),
            Text(
              widget.chat.user.userName,
              style: MyTextStyles(context).font18BlackBold,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              ItemCard(item: widget.chat.item),
              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  buildWhen:
                      (previous, current) =>
                          current is ChatLoading ||
                          current is ChatMessagesLoaded ||
                          current is ChatMessagesError,
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyColors(context).primaryColor,
                        ),
                      );
                    }
                    if (state is ChatMessagesError) {
                      return Center(child: Text(state.error));
                    }
                    if (state is ChatMessagesLoaded) {
                      return Column(
                        children: [
                          Expanded(
                            child:
                                state.messages.isEmpty
                                    ? const Center(
                                      child: Text("No messages yet"),
                                    )
                                    : ListView.builder(
                                      reverse: true,
                                      itemCount: state.messages.length,
                                      itemBuilder: (context, index) {
                                        final isNewDay =
                                            index ==
                                                state.messages.length - 1 ||
                                            state
                                                    .messages[index]
                                                    .timestamp
                                                    .day !=
                                                state
                                                    .messages[index + 1]
                                                    .timestamp
                                                    .day;
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
                            maxLines: 3,
                            minLines: 1,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: MyColors(context).primaryColorDark,
                                onPressed:
                                    _messageController.text.isNotEmpty
                                        ? () {
                                          _chatCubit.sendMessage(
                                            Message(
                                              id: "1",
                                              message: _messageController.text,
                                              senderId: currentUserId,
                                              receiverId:
                                                  widget.chat.user.userId,
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
                              hintStyle:
                                  MyTextStyles(context).font16BrownRegular,
                              filled: true,
                              fillColor: MyColors(context).secondaryColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
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
