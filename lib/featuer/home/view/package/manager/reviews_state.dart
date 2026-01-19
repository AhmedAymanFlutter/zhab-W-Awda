import '../data/model/get_reviews_model.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsSuccess extends ReviewsState {
  final List<ReviewModel> reviews;
  ReviewsSuccess(this.reviews);
}

class ReviewsError extends ReviewsState {
  final String message;
  ReviewsError(this.message);
}
