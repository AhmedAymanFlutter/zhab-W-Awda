import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/review_repository.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final IReviewsRepository repository;

  ReviewsCubit(this.repository) : super(ReviewsInitial());

  Future<void> fetchReviews() async {
    emit(ReviewsLoading());
    try {
      final reviews = await repository.getReviews();
      emit(ReviewsSuccess(reviews));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }
}
