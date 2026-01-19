import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/package_repo.dart';
import 'rate_package_state.dart';

class RatePackageCubit extends Cubit<RatePackageState> {
  final PackagesRepository _repo;

  RatePackageCubit(this._repo) : super(RatePackageInitial());

  Future<void> ratePackage({
    required String packageId,
    required double rating,
    required String comment,
    required String userName,
  }) async {
    emit(RatePackageLoading());
    try {
      await _repo.ratePackage(
        packageId: packageId,
        rating: rating,
        comment: comment,
        userName: userName,
      );
      if (!isClosed) emit(RatePackageSuccess("Rating submitted successfully"));
    } catch (e) {
      if (!isClosed) emit(RatePackageError(e.toString()));
    }
  }
}
