import 'package:pickit/features/post_item/data/models/item.dart';

class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<Item> items;
  BrowseSuccess({required this.items});
}

class BrowseError extends BrowseState {
  final String message;
  BrowseError({required this.message});
}