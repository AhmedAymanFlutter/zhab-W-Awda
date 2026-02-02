import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../model/getHotel_model.dart';
import '../model/get_hotel_id_model.dart';
import '../model/get_countries_model.dart';

class HotelsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetHotelCountriesModel> getHotelCountries() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.hotelsCountries,
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetHotelCountriesModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetHotelModel> getHotels({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Assuming you have EndPoints.hotels defined as 'hotels'
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.hotels,
        queryParameters: queryParameters,
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

  Future<GetHotelIdModel> getHotelById(String id) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.hotels}/$id',
        isProtected: false,
        isFormData: false,
      );

      if (response.status == true && response.data != null) {
        return GetHotelIdModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
