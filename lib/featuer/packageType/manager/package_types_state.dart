import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_countries_by_package_type_model.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_package_type_model.dart';

abstract class PackageTypesState {}

class PackageTypesInitial extends PackageTypesState {}

class PackageTypesLoading extends PackageTypesState {}

class PackageTypesSuccess extends PackageTypesState {
  final List<PackageTypeItem> types;
  PackageTypesSuccess(this.types);
}

class PackageTypesError extends PackageTypesState {
  final String message;
  PackageTypesError(this.message);
}

class PackageTypeCountriesLoading extends PackageTypesState {}

class PackageTypeCountriesSuccess extends PackageTypesState {
  final List<CountryInPackageItem> countries;
  PackageTypeCountriesSuccess(this.countries);
}

class PackageTypeCountriesError extends PackageTypesState {
  final String message;
  PackageTypeCountriesError(this.message);
}

class PackagesInCountryLoading extends PackageTypesState {}

class PackagesInCountrySuccess extends PackageTypesState {
  final List<PackageItem> packages;
  PackagesInCountrySuccess(this.packages);
}

class PackagesInCountryError extends PackageTypesState {
  final String message;
  PackagesInCountryError(this.message);
}
