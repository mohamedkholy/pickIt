class PostItemState {}

class PostItemInitial extends PostItemState {}

class PostItemLoading extends PostItemState {}

class PostItemSuccess extends PostItemState {}

class PostItemError extends PostItemState {
  final String message;

  PostItemError({required this.message});
}

