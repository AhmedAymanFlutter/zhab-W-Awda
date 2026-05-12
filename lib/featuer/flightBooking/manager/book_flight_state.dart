import 'package:flutter_application_1/featuer/flightBooking/data/model/flight_destination_model.dart';

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

class BookFlightSearchLoading extends BookFlightState {}

class BookFlightSearchSuccess extends BookFlightState {
  final List<FlightDestination> results;
  final bool isFromCity;
  BookFlightSearchSuccess(this.results, this.isFromCity);
}

class BookFlightSearchFlightsSuccess extends BookFlightState {
  final dynamic results;
  BookFlightSearchFlightsSuccess(this.results);
}
