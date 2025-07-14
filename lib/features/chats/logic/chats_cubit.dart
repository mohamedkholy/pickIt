import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/chats/data/repos/chats_repo.dart';
import 'package:pickit/features/chats/logic/chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  final ChatsRepo _chatsRepo;
  List<Chat> chats = [];

  ChatsCubit(this._chatsRepo) : super(ChatsLoading());

  void checkUserLoggedIn() async {
    final isLoggedIn = await _chatsRepo.isUserLoggedIn();
    if (!isLoggedIn) {
      emit(UserNotLoggedIn());
    }
    else {
      getChats();
      listenToChats();
    }
  }

  void getChats() async {
    try {
      chats = await _chatsRepo.getChats();
      emit(ChatsLoaded(chats: chats));
    } catch (e) {
      emit(ChatsError(error: e.toString()));
    }
  }

  void listenToChats() {
    _chatsRepo.listenToChats().listen((event) {
      chats = event.docs.map((doc) => Chat.fromJson(doc.data())).toList();
      emit(ChatsLoaded(chats: chats));
    });
  }
  
}
