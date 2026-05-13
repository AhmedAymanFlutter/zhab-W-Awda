import '../data/model/my_bookings_model.dart';

abstract class BookingsState {}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsSuccess extends BookingsState {
  final List<BookingItem> bookings;
  BookingsSuccess(this.bookings);
}

class BookingsError extends BookingsState {
  final String message;
  BookingsError(this.message);
}
