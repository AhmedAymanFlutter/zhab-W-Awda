import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';
import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final CitiesRepository _repository;
  List<CityItem> _allCities = [];
  CitiesCubit(this._repository) : super(CitiesInitial());

  static CitiesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCities() async {
    emit(CitiesLoading());

    try {
      final response = await _repository.getCities();

      // ✅ التحقق قبل إصدار حالة النجاح
      if (!isClosed) {
        if (response.data != null &&
            response.data!.cities != null &&
            response.data!.cities!.isNotEmpty) {
          _allCities = response.data!.cities!;
          emit(CitiesSuccess(response.data!.cities!));
        } else {
          emit(CitiesError("لا توجد وجهات متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق قبل إصدار حالة الخطأ
      if (!isClosed) {
        emit(CitiesError(e.toString()));
      }
    }
  }

  Future<void> getCityDetails(String slug) async {
    emit(CityDetailsLoading());
    try {
      final cityData = await _repository.getCityBySlug(slug);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(CityDetailsSuccess(cityData));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(CityDetailsError(e.toString()));
      }
    }
  }

  void searchLocalCities(String query) {
    if (query.isEmpty) {
      if (!isClosed) emit(CitiesSuccess(_allCities));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredList = _allCities.where((city) {
      final name = city.name?.toLowerCase() ?? '';
      final slug = city.slug?.toLowerCase() ?? '';
      // قمت بإضافة toString() لتجنب مشاكل الـ null safety مع الكائنات المعقدة
      final country = city.country?.toString().toLowerCase() ?? '';

      // Search by Name OR Slug OR Country
      return name.contains(lowerQuery) ||
          slug.contains(lowerQuery) ||
          country.contains(lowerQuery);
    }).toList();

    if (!isClosed) emit(CitiesSuccess(filteredList));
  }
}
