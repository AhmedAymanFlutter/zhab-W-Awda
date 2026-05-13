import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../model/get_all_tours_model.dart';
import '../model/get_tour_id_model.dart';

class ToursRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetAllToursModel> getTours({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.tours,
        queryParameters: queryParameters,
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        return GetAllToursModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TourIdData> getTourById(String id) async {
    try {
      // Endpoint: /tours/admin/:id
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.tours}/$id',
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        final model = GetTourIdModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this tour");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> getCities() async {
    try {
      return await _apiHelper.getRequest(
        endPoint: EndPoints.cities,
        isProtected: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetAllToursModel> getSavedTours({String? query}) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.savedTours,
        queryParameters: query != null ? {'q': query} : null,
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        return GetAllToursModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> toggleSaveTour(String id, bool isSaving) async {
    try {
      if (isSaving) {
        return await _apiHelper.postRequest(
          endPoint: "${EndPoints.savedTours}/$id",
          data: {},
          isAuthorized: true,
        );
      } else {
        return await _apiHelper.deleteRequest(
          endPoint: "${EndPoints.savedTours}/$id",
          isAuthorized: true,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
