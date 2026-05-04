import 'package:flutter_application_1/featuer/tour_guide/data/model/get_tour_guide_details_model.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_CountriesSlug_model.dart';

abstract class TourGuideState {}

class TourGuideInitial extends TourGuideState {}

class TourGuideLoading extends TourGuideState {}

class TourGuideSuccess extends TourGuideState {
  final TourGuideData guideData;
  final CountryDetailsData countryData;
  TourGuideSuccess(this.guideData, this.countryData);
}

class TourGuideError extends TourGuideState {
  final String message;
  TourGuideError(this.message);
}
