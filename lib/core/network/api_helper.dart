import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network/local_data.dart';

import 'api_endpoiont.dart';
import 'api_response.dart';

class APIHelper {
  // singleton
  static final APIHelper _apiHelper = APIHelper._internal();

  factory APIHelper() {
    return _apiHelper;
  }

  APIHelper._internal() {
    // 👇👇 أضف هذا الجزء هنا لتفعيل اللوجات الكاملة
    dio.interceptors.add(
      LogInterceptor(
        request: true, // يظهر تفاصيل الطلب
        requestHeader: true, // يظهر الهيدر المرسل
        requestBody: true, // يظهر البيانات المرسلة (في الـ POST/PUT)
        responseHeader: true, // يظهر هيدر الاستجابة
        responseBody: true, // 🔥 يظهر الـ JSON الكامل القادم من السيرفر
        error: true, // يظهر تفاصيل الأخطاء
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
          headers: {},
          validateStatus: (status) {
            // ✅ قبول جميع الحالات لنتمكن من معالجتها
            return status != null && status < 600;
          },
        ),
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
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
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
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
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
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
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
