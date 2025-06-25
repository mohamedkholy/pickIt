import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

class ChatState {}

class ChatLoading extends ChatState {}

class ChatMessagesLoaded extends ChatState {
  final List<Message> messages;
  ChatMessagesLoaded({required this.messages});
}

class ChatMessagesError extends ChatState {
  final String error;
  ChatMessagesError({required this.error});
}

class ChatError extends ChatState {
  final String error;
  ChatError({required this.error});
}

class ChatMessageSent extends ChatState {}

class ChatMessageReceived extends ChatState {
  final Message message;
  ChatMessageReceived({required this.message});
}

class ChatMessageSentError extends ChatState {
  final String error;
  ChatMessageSentError({required this.error});
}

class ChatItemLoading extends ChatState {}

class ChatItemLoaded extends ChatState {
  final Item item;
  ChatItemLoaded({required this.item});
}

class ChatItemError extends ChatState {
  final String error;
  ChatItemError({required this.error});
}