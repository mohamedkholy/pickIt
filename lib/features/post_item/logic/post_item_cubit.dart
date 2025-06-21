import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/post_item/data/repos/post_item_repo.dart';
import 'package:pickit/features/post_item/logic/post_item_state.dart';

@injectable
class PostItemCubit extends Cubit<PostItemState> {
  final PostItemRepo _postItemRepo;
  PostItemCubit(this._postItemRepo) : super(PostItemInitial());

  Future<void> postItem(Item item) async{
    emit(PostItemLoading());
    try {
      final result = await _postItemRepo.postItem(item);
      if (result) {
        emit(PostItemSuccess());
      } else {
        emit(PostItemError(message: "Failed to post item"));
      }
    } catch (e) {
      emit(PostItemError(message: e.toString()));
    }
  }


  
}