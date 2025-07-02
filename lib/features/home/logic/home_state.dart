import 'package:pickit/features/post_item/data/models/item.dart';

sealed class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Item> items;
  HomeLoaded(this.items);
}

class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}