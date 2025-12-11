// lib/features/flight_booking/logic/book_flight_state.dart

abstract class BookFlightState {}

class BookFlightInitial extends BookFlightState {}

class BookFlightLoading extends BookFlightState {}

class BookFlightSuccess extends BookFlightState {}

class BookFlightError extends BookFlightState {
  final String message;
  BookFlightError(this.message);
}
