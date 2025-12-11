import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';

import '../data/model/get_package_id_model.dart';

abstract class PackagesState {}

class PackagesInitial extends PackagesState {}

class PackagesLoading extends PackagesState {}

class PackagesSuccess extends PackagesState {
  final List<PackageItem> packages;
  PackagesSuccess(this.packages);
}

class PackagesError extends PackagesState {
  final String message;
  PackagesError(this.message);
}

class PackageDetailsLoading extends PackagesState {}

class PackageDetailsSuccess extends PackagesState {
  final PackageIdData package;
  PackageDetailsSuccess(this.package);
}

class PackageDetailsError extends PackagesState {
  final String message;
  PackageDetailsError(this.message);
}
