import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chat/data/repos/chat_repo.dart';
import 'package:pickit/features/chat/logic/chat_state.dart';
import 'package:pickit/features/chats/data/models/chat.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _chatRepo;
  List<Message> messages = [];
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
  streamSubscription;
  ChatCubit(this._chatRepo) : super(ChatLoading());

  void sendMessage(Message message, Chat chat) async {
    if (messages.isEmpty) {
      await _chatRepo.createChat(chat);
    }
    final result = await _chatRepo.sendMessage(message, chat);
    if (result) {
      emit(ChatMessageSent());
    } else {
      emit(ChatMessageSentError(error: "Failed to send message"));
    }
  }

  void getMessages(Chat chat) async {
    final messages = await _chatRepo.getMessages(chat);
    if (messages != null) {
      this.messages = messages;
      emit(ChatMessagesLoaded(messages: messages));
    } else {
      emit(ChatMessagesError(error: "Failed to load messages"));
    }
  }

  void listenToChat(Chat chat) {
    streamSubscription = _chatRepo.listenToChat(chat.id).listen((event) async {
      for (var change in event.docChanges) {
        if (change.type == DocumentChangeType.added) {
          messages.insert(0, Message.fromJson(change.doc.data()!));
        }
      }
      await _chatRepo.updateChatUnreadMessages(chat.id);
      emit(ChatMessagesLoaded(messages: messages));
    });
  }

  String getUserID() {
    return _chatRepo.currentUser.uid;
  }

  void getItem(String chatId) {
    emit(ChatItemLoading());
    _chatRepo.getItem(chatId).then((value) {
      if (value != null) {
        emit(ChatItemLoaded(item: value));
      } else {
        emit(ChatItemError(error: "Failed to load item"));
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
