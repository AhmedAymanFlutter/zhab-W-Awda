import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_countries_by_package_type_model.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_package_type_model.dart';
import 'package:flutter_application_1/featuer/packageType/data/model/get_packages_in_country_model.dart';

import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';

class PackageTypesRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetPackageTypeModel> getPackageTypes() async {
    try {
      // Assuming EndPoints.packageTypes = 'packageTypes'
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints
            .packageTypes, // Ensure this exists in your EndPoints class
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetPackageTypeModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CountryInPackageItem>> getCountriesByPackageType(
    String slug,
  ) async {
    try {
      // Endpoint: /packageTypes/:slug
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.packageTypes}/$slug',
        isProtected: false,
      );

      // The API returns { "success": true, "data": [ ... ] }
      if (response.data['success'] == true && response.data['data'] != null) {
        final model = GetCountriesByPackageTypeModel.fromJson(response.data);
        return model.data ?? [];
      } else {
        throw Exception(
          response.data['message'] ?? "Failed to load destinations",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PackageItem>> getPackagesByTypeAndCountry({
    required String packageTypeSlug,
    required String countrySlug,
  }) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint:
            '${EndPoints.packageTypes}/$packageTypeSlug/packages/$countrySlug',
        isProtected: false,
      );

      if (response.data['success'] == true && response.data['data'] != null) {
        final model = GetPackagesInCountryModel.fromJson(response.data);
        return model.data ?? [];
      } else {
        throw Exception(response.data['message'] ?? "Failed to load packages");
      }
    } catch (e) {
      rethrow;
    }
  }
}
