import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import '../../../../../../core/network/api_endpoiont.dart';
import '../../../../../../core/network/api_helper.dart';
import '../model/get_package_id_model.dart';

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
}
