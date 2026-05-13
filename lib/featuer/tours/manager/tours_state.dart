import 'package:flutter_application_1/featuer/tours/data/model/get_tour_id_model.dart';

import '../data/model/get_all_tours_model.dart';

abstract class ToursState {}

class ToursInitial extends ToursState {}

class ToursLoading extends ToursState {}

class ToursSuccess extends ToursState {
  final List<TourItem> tours;
  final Pagination? pagination;
  ToursSuccess(this.tours, {this.pagination});
}

class ToursError extends ToursState {
  final String message;
  ToursError(this.message);
}

class TourDetailsLoading extends ToursState {}

class TourDetailsSuccess extends ToursState {
  final TourIdData tour;
  TourDetailsSuccess(this.tour);
}

class TourDetailsError extends ToursState {
  final String message;
  TourDetailsError(this.message);
}

class SavedToursLoading extends ToursState {}

class SavedToursSuccess extends ToursState {
  final List<TourItem> tours;
  SavedToursSuccess(this.tours);
}

class SavedToursError extends ToursState {
  final String message;
  SavedToursError(this.message);
}

class ToggleSaveTourSuccess extends ToursState {
  final String message;
  ToggleSaveTourSuccess(this.message);
}
