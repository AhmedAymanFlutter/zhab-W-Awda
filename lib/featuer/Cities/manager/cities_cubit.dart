import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final CitiesRepository _repository;

  CitiesCubit(this._repository) : super(CitiesInitial());

  static CitiesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchCities() async {
    emit(CitiesLoading());

    try {
      final response = await _repository.getCities();

      if (response.data != null &&
          response.data!.cities != null &&
          response.data!.cities!.isNotEmpty) {
        emit(CitiesSuccess(response.data!.cities!));
      } else {
        emit(CitiesError("لا توجد وجهات متاحة حالياً"));
      }
    } catch (e) {
      emit(CitiesError(e.toString()));
    }
  }

  Future<void> getCityDetails(String slug) async {
    emit(CityDetailsLoading());
    try {
      final cityData = await _repository.getCityBySlug(slug);
      emit(CityDetailsSuccess(cityData));
    } catch (e) {
      emit(CityDetailsError(e.toString()));
    }
  }
}
