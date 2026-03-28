import '../entities/review.dart';

abstract class IReviewsRepository {
  Future<List<Review>> getReviews();
}
