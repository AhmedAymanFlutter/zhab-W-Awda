import '../models/review_model.dart';

abstract class IReviewsDataSource {
  Future<List<ReviewModel>> getReviews();
}

class LocalReviewsDataSource implements IReviewsDataSource {
  @override
  Future<List<ReviewModel>> getReviews() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return getReviews(); // This is the function from review_data.dart
  }
}
