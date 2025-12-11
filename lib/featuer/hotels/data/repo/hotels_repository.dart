import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../model/getHotel_model.dart';
import '../model/get_hotel_id_model.dart';

class HotelsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetHotelModel> getHotels() async {
    try {
      // Assuming you have EndPoints.hotels defined as 'hotels'
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.hotels,
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetHotelModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<HotelIdData> getHotelById(String id) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.hotels}/admin/$id',
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        final model = GetHotelIdModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this hotel");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
