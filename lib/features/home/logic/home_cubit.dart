import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/home/data/home_repo.dart';
import 'package:pickit/features/home/logic/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeLoading());

  Future<void> getFeaturedItems() async {
    emit(HomeLoading());
    final items = await _homeRepo.getFeaturedItems();
    emit(HomeLoaded(items));
  }
}
