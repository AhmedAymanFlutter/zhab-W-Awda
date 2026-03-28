import '../../domain/entities/review.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/reviews_datasource.dart';

class ReviewsRepositoryImpl implements IReviewsRepository {
  final IReviewsDataSource dataSource;

  ReviewsRepositoryImpl(this.dataSource);

  @override
  Future<List<Review>> getReviews() async {
    return await dataSource.getReviews();
  }
}
