import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import '../../../../../../core/network/api_endpoiont.dart';
import '../../../../../../core/network/api_helper.dart';
import '../model/get_package_id_model.dart';
import '../model/get_reviews_model.dart';

class PackagesRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<GetAllPackagesModel> getPackages() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.packages, // Ensure this endpoint exists
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetAllPackagesModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageIdData> getPackageById(String id) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.packages}admin/$id',
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        final model = GetPackageIdModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this package");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageIdData> getPackageDetailsBySlug(
    String packageTypeSlug,
    String packageSlug,
  ) async {
    try {
      // url: {{baseUrl}}/packageTypes/:packageTypeSlug/packages/:packageSlug
      final response = await _apiHelper.getRequest(
        endPoint:
            '${EndPoints.packageTypes}/$packageTypeSlug/${EndPoints.packages}$packageSlug',
        isProtected: false,
      );

      // The new response structure has success: true/false
      if (response.data != null && response.data['success'] == true) {
        final model = GetPackageIdModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found");
        }
      } else {
        throw Exception(response.data['message'] ?? "Unknown error");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> ratePackage({
    required String packageId,
    required double rating,
    required String comment,
    required String userName,
  }) async {
    try {
      final response = await _apiHelper.postRequest(
        endPoint:
            'rates', // Assuming 'rates' is not in EndPoints yet or use literal
        data: {
          "package": packageId,
          "rate": rating,
          "content": comment,
          "authorName": userName,
        },
        isAuthorized: false,
        isFormData: false, // Send as JSON
      );

      if (response.data['success'] == true || response.status == true) {
        // check both conventions
        // Success
      } else {
        throw Exception(
          response.data['message'] ?? response.message ?? "Rating failed",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetReviewsResponse> getPackageReviews(String slug) async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: 'rates/package/$slug',
        isProtected: false,
      );
      if (response.status == true && response.data != null) {
        return GetReviewsResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
