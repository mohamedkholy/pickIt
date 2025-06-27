import 'package:pickit/features/post_item/data/models/item.dart';

sealed class SearchState {}

class InitialState extends SearchState {}

class Searching extends SearchState {}

class Searched extends SearchState {
  final List<Item> items;

  Searched({required this.items});
}

class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}
