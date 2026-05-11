import '../models/review_model.dart';

abstract class IReviewsDataSource {
  Future<List<ReviewModel>> getReviews();
}

class LocalReviewsDataSource implements IReviewsDataSource {
  @override
  Future<List<ReviewModel>> getReviews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getReviews();
  }
}
