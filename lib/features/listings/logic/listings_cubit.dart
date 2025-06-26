import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/listings/data/repos/listings_repo.dart';
import 'package:pickit/features/listings/logic/listings_state.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class ListingsCubit extends Cubit<ListingsState> {
  final ListingsRepo _listingsRepo;
  final String _currentUser = FirebaseAuth.instance.currentUser!.uid;
  ListingsCubit(this._listingsRepo) : super(ListingsInitial());

  Future<void> getListings() async {
    emit(ListingsLoading());
    final listings = await _listingsRepo.getListings(_currentUser);
    emit(ListingsLoaded(listings ?? []));
  }

  void updateState(Item item, ListingStatus status) async {
    emit(ListingsLoading());
    final result = await _listingsRepo.updateState(item, status);
    if (result == true) {
      getListings();
    } else {
      emit(ListingsError("Failed to update item"));
    }
  }

  void deleteItem(Item item) async {
    emit(ListingsLoading());
    final result = await _listingsRepo.deleteItem(item);
    if (result == true) {
      getListings();
    } else {
      emit(ListingsError("Failed to delete item"));
    }
  }

  void initState(List<Item> items) {
    emit(ListingsLoaded(items));
  }
}
