// lib/features/services/data/repo/services_repository.dart

import 'package:flutter_application_1/featuer/services/data/model/get_service_id_model.dart';
import 'package:flutter_application_1/featuer/services/data/model/get_services_model.dart';

import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';

class ServicesRepository {
  final APIHelper _apiHelper = APIHelper();

  // 1. Get All Services
  Future<GetServicesModel> getServices() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.services,
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        return GetServicesModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  // 2. Get Service Details
  Future<ServiceIdData> getServiceById(String id) async {
    try {
      // Endpoint: /services/admin/:id
      // Use '${EndPoints.services}/$id' if public API
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.services}/$id',
        isProtected: false,
      );

      if (response.status == true && response.data != null) {
        final model = GetServiceIdModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("No data found for this service");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
