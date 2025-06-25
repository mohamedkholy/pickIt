import 'package:pickit/features/chats/data/models/chat.dart';

class ChatsState {}

class UserNotLoggedIn extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<Chat> chats;
  ChatsLoaded({required this.chats});
}

class ChatsError extends ChatsState {
  final String error;

  ChatsError({required this.error});
}
