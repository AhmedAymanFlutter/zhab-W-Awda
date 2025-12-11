import 'package:flutter_application_1/featuer/countries/data/model/get_CountriesSlug_model.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesSuccess extends CountriesState {
  final List<CountryItem> countries;
  CountriesSuccess(this.countries);
}

class CountriesError extends CountriesState {
  final String message;
  CountriesError(this.message);
}

class CountryDetailsLoading extends CountriesState {}

class CountryDetailsSuccess extends CountriesState {
  final CountryDetailsData country;
  CountryDetailsSuccess(this.country);
}

class CountryDetailsError extends CountriesState {
  final String message;
  CountryDetailsError(this.message);
}
