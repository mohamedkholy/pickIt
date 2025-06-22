class PostItemState {}

class PostItemInitial extends PostItemState {}

class PostItemLoading extends PostItemState {}

class PostItemSuccess extends PostItemState {}

class PostItemError extends PostItemState {
  final String message;

  PostItemError({required this.message});
}

class FetchingCity extends PostItemState {}

class CityFetched extends PostItemState {
  final String city;

  CityFetched({required this.city});
}

class CityFetchingError extends PostItemState {
  final String error;

  CityFetchingError({required this.error});
}