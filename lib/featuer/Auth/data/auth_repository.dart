import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/core/network/api_endpoiont.dart';
import 'package:flutter_application_1/core/network/api_response.dart';

class AuthRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> register({
    required String countryCode,
    required String name,
    required String phone,
    required String password,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authRegister,
      data: {
        "countryCode": countryCode,
        "name": name,
        "phone": phone,
        "password": password,
      },
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> login({
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authLogin,
      data: {"countryCode": countryCode, "phone": phone, "password": password},
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> forgotPassword({
    required String countryCode,
    required String phone,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authForgotPassword,
      data: {"countryCode": countryCode, "phone": phone},
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirm,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authResetPassword,
      data: {
        "resetToken": resetToken,
        "password": password,
        "passwordConfirm": passwordConfirm,
      },
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> resendOtp({
    required String countryCode,
    required String phone,
    required String purpose,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authResendOtp,
      data: {"countryCode": countryCode, "phone": phone, "purpose": purpose},
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> verifyOtp({
    required String countryCode,
    required String phone,
    required String code,
    required String purpose,
  }) async {
    return await _apiHelper.postRequest(
      endPoint: EndPoints.authVerifyOtp,
      data: {
        "countryCode": countryCode,
        "phone": phone,
        "code": code,
        "purpose": purpose,
      },
      isFormData: false,
      isAuthorized: false,
    );
  }

  Future<ApiResponse> changePassword({
    required String password,
    required String newPassword,
    required String passwordConfirm,
  }) async {
    return await _apiHelper.patchRequest(
      endPoint: EndPoints.authChangePassword,
      data: {
        "password": password,
        "newPassword": newPassword,
        "passwordConfirm": passwordConfirm,
      },
      isFormData: false,
      isAuthorized: true,
    );
  }
}
