import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/countries_repository.dart';
import 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRepository _repository;
  List<CountryItem> _allCountries = [];
  CountriesCubit(this._repository) : super(CountriesInitial());

  static CountriesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCountries() async {
    emit(CountriesLoading());

    try {
      final response = await _repository.getCountries();

      // ✅ التحقق قبل إصدار الحالة
      if (!isClosed) {
        if (response.data != null &&
            response.data!.countries != null &&
            response.data!.countries!.isNotEmpty) {
          _allCountries = response.data!.countries!;
          emit(CountriesSuccess(response.data!.countries!));
        } else {
          emit(CountriesError("لا توجد دول متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند الخطأ
      if (!isClosed) {
        emit(CountriesError(e.toString()));
      }
    }
  }

  Future<void> getCountryDetails(String slug) async {
    emit(CountryDetailsLoading());
    try {
      final country = await _repository.getCountryBySlug(slug);

      // ✅ التحقق هنا
      if (!isClosed) {
        emit(CountryDetailsSuccess(country));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(CountryDetailsError(e.toString()));
      }
    }
  }

  void searchLocalCountries(String query) {
    if (query.isEmpty) {
      if (!isClosed) emit(CountriesSuccess(_allCountries));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredList = _allCountries.where((country) {
      final name = country.name?.toLowerCase() ?? '';
      final continent = country.continent?.toLowerCase() ?? '';

      // Search by Name OR Continent
      return name.contains(lowerQuery) || continent.contains(lowerQuery);
    }).toList();

    if (!isClosed) emit(CountriesSuccess(filteredList));
  }
}
