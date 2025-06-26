import 'package:pickit/features/post_item/data/models/item.dart';

sealed class ListingsState {}

class ListingsInitial extends ListingsState {}

class ListingsLoading extends ListingsState {}

class ListingsLoaded extends ListingsState {
  final List<Item> listings;
  ListingsLoaded(this.listings);
}

class ListingsError extends ListingsState {
  final String error;
  ListingsError(this.error);
}
