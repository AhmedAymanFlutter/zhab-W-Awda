// lib/features/cities/data/repo/cities_repository.dart

import 'package:flutter_application_1/featuer/Cities/data/model/get_city_details_model.dart';
import 'package:flutter_application_1/featuer/Cities/data/model/getcitiesModel.dart';

import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';

class CitiesRepository {
  final APIHelper _apiHelper = APIHelper();

  // 1. Get All Cities
  Future<GetCitiesModel> getCities() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.cities,
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetCitiesModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  // 2. Get City Details
  Future<CityDetailsData> getCityBySlug(String slug) async {
    try {
      // Endpoint: /cities/:citySlug
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.cities}/$slug',
        isProtected: false,
      );

      // Check success flag (API returns 'success': true)
      if ((response.data['success'] == true || response.status == true) &&
          response.data != null) {
        final model = GetCityDetailsModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this city");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
