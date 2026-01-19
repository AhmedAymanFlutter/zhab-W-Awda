abstract class RatePackageState {}

class RatePackageInitial extends RatePackageState {}

class RatePackageLoading extends RatePackageState {}

class RatePackageSuccess extends RatePackageState {
  final String message;
  RatePackageSuccess(this.message);
}

class RatePackageError extends RatePackageState {
  final String message;
  RatePackageError(this.message);
}
