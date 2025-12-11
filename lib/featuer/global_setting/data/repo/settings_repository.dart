import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../models/get_settings_model.dart';

class SettingsRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetSettingsModel> getSettings() async {
    try {
      // Endpoint: /settings
      final response = await _apiHelper.getRequest(
        endPoint:
            EndPoints.settings, // Ensure this is defined in your endpoints
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetSettingsModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
