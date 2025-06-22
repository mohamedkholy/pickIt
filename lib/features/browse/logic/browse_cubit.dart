import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/browse/data/repos/browse_repo.dart';
import 'package:pickit/features/browse/logic/browse_state.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  final BrowseRepo _browseRepo;
  BrowseCubit(this._browseRepo) : super(BrowseInitial());

  Future<void> getItems({String? category}) async {
    emit(BrowseLoading());
    final items = await _browseRepo.getItems(category: category);
    if (items.isEmpty) {
      emit(BrowseError(message: "No items found"));
    } else {
      emit(BrowseSuccess(items: items));
    }
  }
}