// lib/features/countries/data/repo/countries_repository.dart

import 'package:flutter_application_1/featuer/countries/data/model/get_CountriesSlug_model.dart';
import 'package:flutter_application_1/featuer/countries/data/model/get_countries_model.dart';

import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';

class CountriesRepository {
  final APIHelper _apiHelper = APIHelper();

  // 1. Get All Countries
  Future<GetCountriesModel> getCountries() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.countries,
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetCountriesModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  // 2. Get Country Details by Slug
  Future<CountryDetailsData> getCountryBySlug(String slug) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.countries}/$slug',
        isProtected: false,
      );

      if ((response.data['success'] == true || response.status == true) &&
          response.data != null) {
        final model = GetCountryDetailsModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this country");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
