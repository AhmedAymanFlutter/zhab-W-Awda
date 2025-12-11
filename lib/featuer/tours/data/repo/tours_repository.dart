import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../model/get_all_tours_model.dart';
import '../model/get_tour_id_model.dart';

class ToursRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetAllToursModel> getTours() async {
    try {
      // Assuming EndPoints.tours = 'tours'
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.tours,
        isProtected: false,
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
        endPoint: '${EndPoints.tours}/admin/$id',
        isProtected: false,
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
}
