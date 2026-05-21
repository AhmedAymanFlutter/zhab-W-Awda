import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/local_data.dart';

import 'api_endpoiont.dart';
import 'api_response.dart';
import 'network_error_manager.dart';

class APIHelper {
  // singleton
  static final APIHelper _apiHelper = APIHelper._internal();

  factory APIHelper() {
    return _apiHelper;
  }

  APIHelper._internal() {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
  // declaring dio
  Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: Duration(seconds: 20),
      sendTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    ),
  );

  // GET request مبسط
  Future<ApiResponse> getRequest({
    required String endPoint,
    String? resourcePath,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = true,
    bool isProtected = false,
    bool sendRefreshToken = false,
  }) async {
    try {
      final String finalEndpoint =
          resourcePath != null && resourcePath.isNotEmpty
          ? '$endPoint/$resourcePath'
          : endPoint;

      final response = await dio.get(
        finalEndpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (isProtected && LocalData.accessToken != null)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
          validateStatus: (status) {
            // ✅ قبول جميع الحالات لنتمكن من معالجتها
            return status != null && status < 600;
          },
        ),
      );

      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.status) {
        NetworkErrorManager.reportError(apiResponse.message);
      }
      return apiResponse;
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      NetworkErrorManager.reportError(apiResponse.message);
      return apiResponse;
    }
  }

  // PUT request
  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.status) {
        NetworkErrorManager.reportError(apiResponse.message);
      }
      return apiResponse;
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      NetworkErrorManager.reportError(apiResponse.message);
      return apiResponse;
    }
  }

  // DELETE request
  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.status) {
        NetworkErrorManager.reportError(apiResponse.message);
      }
      return apiResponse;
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      NetworkErrorManager.reportError(apiResponse.message);
      return apiResponse;
    }
  }

  // POST request
  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data, // Use consistent naming
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
            'Content-Type': isFormData
                ? 'multipart/form-data'
                : 'application/json',
          },
        ),
      );
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.status) {
        NetworkErrorManager.reportError(apiResponse.message);
      }
      return apiResponse;
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      NetworkErrorManager.reportError(apiResponse.message);
      return apiResponse;
    }
  }

  // PATCH request
  Future<ApiResponse> patchRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.patch(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              "Authorization": "Bearer ${LocalData.accessToken}",
          },
        ),
      );
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.status) {
        NetworkErrorManager.reportError(apiResponse.message);
      }
      return apiResponse;
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      NetworkErrorManager.reportError(apiResponse.message);
      return apiResponse;
    }
  }
}
