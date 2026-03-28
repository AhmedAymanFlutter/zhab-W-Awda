import '../../domain/entities/review.dart';

abstract class ReviewsState {}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsSuccess extends ReviewsState {
  final List<Review> reviews;
  ReviewsSuccess(this.reviews);
}

class ReviewsError extends ReviewsState {
  final String message;
  ReviewsError(this.message);
}
