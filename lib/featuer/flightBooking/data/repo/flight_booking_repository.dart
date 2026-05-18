// lib/features/flight_booking/data/repo/flight_booking_repository.dart

import 'package:flutter_application_1/featuer/flightBooking/data/model/book_flight_request_model.dart';
import 'package:flutter_application_1/featuer/flightBooking/data/model/flight_destination_model.dart';

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

  Future<List<FlightDestination>> searchDestinations(String query) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: 'flights/search-destination?query=$query',
      );

      if (response.status == true) {
        return FlightDestinationResponse.fromJson(response.data).data ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> searchFlights({
    required String fromId,
    required String toId,
    required String departDate,
    int adults = 1,
    String? childrenAges,
    String sort = 'BEST',
    String cabinClass = 'ECONOMY',
    String currencyCode = 'SAR',
  }) async {
    try {
      String url =
          'flights/search?fromId=$fromId&toId=$toId&departDate=$departDate&adults=$adults&sort=$sort&cabinClass=$cabinClass&currency_code=$currencyCode';
      if (childrenAges != null && childrenAges.isNotEmpty) {
        url += '&children_ages=$childrenAges';
      }

      final response = await _apiHelper.getRequest(endPoint: url);

      if (response.status == true) {
        return response
            .data; // Return raw data for now, or map to a model if we had one
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
