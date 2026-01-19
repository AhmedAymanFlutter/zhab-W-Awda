import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/package_repo.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final PackagesRepository _repo;

  ReviewsCubit(this._repo) : super(ReviewsInitial());

  Future<void> getReviews(String slug) async {
    emit(ReviewsLoading());
    try {
      final response = await _repo.getPackageReviews(slug);
      if (response.data?.reviews != null) {
        emit(ReviewsSuccess(response.data!.reviews!));
      } else {
        emit(ReviewsSuccess([])); // Empty list if no data
      }
    } catch (e) {
      if (!isClosed) emit(ReviewsError(e.toString()));
    }
  }
}
