// lib/features/flight_booking/data/repo/flight_booking_repository.dart

import 'package:flutter_application_1/featuer/flightBooking/data/model/book_flight_request_model.dart';

import '../../../../core/network/api_helper.dart';

class FlightBookingRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<void> bookFlight(BookFlightRequestModel requestModel) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint: 'flightBookings',
        data: requestModel.toJson(),
        isFormData: false,
      );

      if (response.status == true) {
        return; // Success
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
