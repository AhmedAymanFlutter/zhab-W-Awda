import 'package:flutter_application_1/featuer/Cities/data/model/get_city_details_model.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';

abstract class CitiesState {}

class CitiesInitial extends CitiesState {}

class CitiesLoading extends CitiesState {}

class CitiesSuccess extends CitiesState {
  final List<CityItem> cities;
  CitiesSuccess(this.cities);
}

class CitiesError extends CitiesState {
  final String message;
  CitiesError(this.message);
}

class CityDetailsLoading extends CitiesState {}

class CityDetailsSuccess extends CitiesState {
  final CityDetailsData cityData;
  CityDetailsSuccess(this.cityData);
}

class CityDetailsError extends CitiesState {
  final String message;
  CityDetailsError(this.message);
}
