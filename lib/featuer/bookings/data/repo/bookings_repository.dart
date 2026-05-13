import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../model/my_bookings_model.dart';
import '../model/booking_details_model.dart';

class BookingsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<MyBookingsModel> getMyBookings({String? status}) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.myBookings,
        queryParameters: status != null ? {'status': status} : null,
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        return MyBookingsModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<BookingDetailsModel> getBookingDetails(String bookingId) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: "${EndPoints.myBookings}/$bookingId",
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        return BookingDetailsModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
