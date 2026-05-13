import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/bookings_repository.dart';
import 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  final BookingsRepository _repository;

  BookingDetailsCubit(this._repository) : super(BookingDetailsInitial());

  Future<void> fetchBookingDetails(String bookingId) async {
    emit(BookingDetailsLoading());
    try {
      final response = await _repository.getBookingDetails(bookingId);
      if (response.data?.booking != null) {
        emit(BookingDetailsSuccess(response.data!.booking!));
      } else {
        emit(BookingDetailsError("لم يتم العثور على تفاصيل الحجز"));
      }
    } catch (e) {
      emit(BookingDetailsError(e.toString()));
    }
  }
}
