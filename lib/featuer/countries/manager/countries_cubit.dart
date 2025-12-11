import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/countries_repository.dart';
import 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRepository _repository;

  CountriesCubit(this._repository) : super(CountriesInitial());

  static CountriesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCountries() async {
    emit(CountriesLoading());

    try {
      final response = await _repository.getCountries();

      if (response.data != null &&
          response.data!.countries != null &&
          response.data!.countries!.isNotEmpty) {
        emit(CountriesSuccess(response.data!.countries!));
      } else {
        emit(CountriesError("لا توجد دول متاحة حالياً"));
      }
    } catch (e) {
      emit(CountriesError(e.toString()));
    }
  }

  Future<void> getCountryDetails(String slug) async {
    emit(CountryDetailsLoading());
    try {
      final country = await _repository.getCountryBySlug(slug);
      emit(CountryDetailsSuccess(country));
    } catch (e) {
      emit(CountryDetailsError(e.toString()));
    }
  }
}
