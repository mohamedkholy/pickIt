import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/search/data/repos/search_repo.dart';
import 'package:pickit/features/search/logic/search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  String query = "";
  final SearchRepo _repo;

  SearchCubit(this._repo) : super(InitialState());

  void search(String? query) async {
    if (query == null || query.isEmpty) {
      emit(InitialState());
      return;
    }
    this.query = query;
    emit(Searching());
    final items = await _repo.search(query);
    if (items != null) {
      emit(Searched(items: items));
    } else {
      emit(SearchError(error: "Search failed please try again"));
    }
  }
}
