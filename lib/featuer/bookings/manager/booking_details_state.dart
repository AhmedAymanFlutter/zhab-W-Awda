import '../data/model/booking_details_model.dart';

abstract class BookingDetailsState {}

class BookingDetailsInitial extends BookingDetailsState {}

class BookingDetailsLoading extends BookingDetailsState {}

class BookingDetailsSuccess extends BookingDetailsState {
  final BookingDetail booking;
  BookingDetailsSuccess(this.booking);
}

class BookingDetailsError extends BookingDetailsState {
  final String message;
  BookingDetailsError(this.message);
}
