import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/bookings_repository.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final BookingsRepository _repository;

  BookingsCubit(this._repository) : super(BookingsInitial());

  Future<void> fetchMyBookings({String? status}) async {
    emit(BookingsLoading());
    try {
      final response = await _repository.getMyBookings(status: status);
      if (response.data != null) {
        emit(BookingsSuccess(response.data!));
      } else {
        emit(BookingsError("لا توجد حجوزات متاحة حالياً"));
      }
    } catch (e) {
      emit(BookingsError(e.toString()));
    }
  }
}
