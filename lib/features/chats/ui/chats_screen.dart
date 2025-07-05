// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/not_signed_in_widget.dart';
import 'package:pickit/features/chats/logic/chats_cubit.dart';
import 'package:pickit/features/chats/logic/chats_state.dart';
import 'package:pickit/features/chats/ui/widgets/chat_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final ChatsCubit _chatsCubit = context.read<ChatsCubit>();

  @override
  void initState() {
    super.initState();
    _chatsCubit.checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FirebaseAuth.instance.currentUser == null
              ? MyColors(context).white
              : MyColors(context).secondaryColor,
      appBar: AppBar(
        title: Text("Chats", style: MyTextStyles(context).font18BlackBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            if (state is UserNotLoggedIn) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: NotSignedInWidget(),
                ),
              );
            }
            if (state is ChatsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors(context).primaryColor,
                ),
              );
            }
            if (state is ChatsError) {
              return Center(child: Text(state.error));
            }
            if (state is ChatsLoaded) {
              if (state.chats.isEmpty) {
                return const Center(child: Text("No chats found"));
              }
              return ListView.builder(
                itemCount: state.chats.length,
                itemBuilder:
                    (context, index) => ChatItem(chat: state.chats[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
