import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/package_repo.dart';
import 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository _repository;

  PackagesCubit(this._repository) : super(PackagesInitial());

  static PackagesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchPackages() async {
    emit(PackagesLoading());

    try {
      final response = await _repository.getPackages();

      if (response.data != null &&
          response.data!.packages != null &&
          response.data!.packages!.isNotEmpty) {
        emit(PackagesSuccess(response.data!.packages!));
      } else {
        emit(PackagesError("لا توجد باقات متاحة حالياً"));
      }
    } catch (e) {
      emit(PackagesError(e.toString()));
    }
  }

  Future<void> getPackageDetails(String id) async {
    emit(PackageDetailsLoading());

    try {
      final package = await _repository.getPackageById(id);
      emit(PackageDetailsSuccess(package));
    } catch (e) {
      emit(PackageDetailsError(e.toString()));
    }
  }
}
