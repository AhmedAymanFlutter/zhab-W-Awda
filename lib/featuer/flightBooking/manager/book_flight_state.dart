import '../data/model/book_flight_request_model.dart';

abstract class BookFlightState {}

class BookFlightInitial extends BookFlightState {}

class BookFlightLoading extends BookFlightState {}

class BookFlightSuccess extends BookFlightState {
  final BookFlightRequestModel requestModel;
  BookFlightSuccess(this.requestModel);
}

class BookFlightError extends BookFlightState {
  final String message;
  BookFlightError(this.message);
}

class BookFlightTripTypeChanged extends BookFlightState {}
