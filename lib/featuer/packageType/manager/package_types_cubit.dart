import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/package_types_repository.dart';
import 'package_types_state.dart';

class PackageTypesCubit extends Cubit<PackageTypesState> {
  final PackageTypesRepository _repository;

  PackageTypesCubit(this._repository) : super(PackageTypesInitial());

  static PackageTypesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchPackageTypes() async {
    emit(PackageTypesLoading());

    try {
      final response = await _repository.getPackageTypes();

      // ✅ التحقق قبل إصدار الحالة
      if (!isClosed) {
        if (response.data != null &&
            response.data!.packageTypes != null &&
            response.data!.packageTypes!.isNotEmpty) {
          emit(PackageTypesSuccess(response.data!.packageTypes!));
        } else {
          emit(PackageTypesError("لا توجد أنواع باقات متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند الخطأ
      if (!isClosed) {
        emit(PackageTypesError(e.toString()));
      }
    }
  }

  Future<void> fetchCountriesByType(String slug) async {
    emit(PackageTypeCountriesLoading());
    try {
      final countries = await _repository.getCountriesByPackageType(slug);

      // ✅ التحقق هنا
      if (!isClosed) {
        if (countries.isNotEmpty) {
          emit(PackageTypeCountriesSuccess(countries));
        } else {
          emit(
            PackageTypeCountriesError("لا توجد وجهات متاحة لهذا النوع حالياً"),
          );
        }
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(PackageTypeCountriesError(e.toString()));
      }
    }
  }

  Future<void> fetchPackagesInCountry({
    required String packageTypeSlug,
    required String countrySlug,
  }) async {
    emit(PackagesInCountryLoading());
    try {
      final packages = await _repository.getPackagesByTypeAndCountry(
        packageTypeSlug: packageTypeSlug,
        countrySlug: countrySlug,
      );

      // ✅ التحقق هنا
      if (!isClosed) {
        if (packages.isNotEmpty) {
          emit(PackagesInCountrySuccess(packages));
        } else {
          emit(
            PackagesInCountryError("لا توجد باقات متاحة في هذه الوجهة حالياً"),
          );
        }
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(PackagesInCountryError(e.toString()));
      }
    }
  }
}
