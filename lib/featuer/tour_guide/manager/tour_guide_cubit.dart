import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/featuer/countries/data/repo/countries_repository.dart';
import '../data/repo/tour_guide_repository.dart';
import 'tour_guide_state.dart';

class TourGuideCubit extends Cubit<TourGuideState> {
  final TourGuideRepository _repository;
  final CountriesRepository _countriesRepository;

  TourGuideCubit(this._repository, this._countriesRepository) : super(TourGuideInitial());

  Future<void> getTourGuideDetails(String slug) async {
    emit(TourGuideLoading());
    try {
      final results = await Future.wait([
        _repository.getTourGuideDetails(slug),
        _countriesRepository.getCountryBySlug(slug),
      ]);
      
      emit(TourGuideSuccess(results[0] as dynamic, results[1] as dynamic));
    } catch (e) {
      emit(TourGuideError(e.toString()));
    }
  }
}
