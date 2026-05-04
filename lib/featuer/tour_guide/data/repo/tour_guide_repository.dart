import 'package:flutter_application_1/featuer/tour_guide/data/model/get_tour_guide_details_model.dart';
import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';

class TourGuideRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<TourGuideData> getTourGuideDetails(String slug) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.tourGuides}/$slug',
        isProtected: false,
      );

      if (response.data['success'] == true && response.data != null) {
        final model = GetTourGuideDetailsModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this tour guide");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
