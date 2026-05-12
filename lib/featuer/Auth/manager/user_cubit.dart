import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/core/network/local_data.dart';
import 'package:flutter_application_1/featuer/Auth/data/auth_repository.dart';
import 'package:flutter_application_1/featuer/Auth/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_state.dart';

class UserCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  UserCubit() : super(AuthInitial());

  Future<void> register({
    required String countryCode,
    required String name,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.register(
      countryCode: countryCode,
      name: name,
      phone: phone,
      password: password,
    );

    if (response.status) {
      emit(AuthRegisterSuccess(response.message));
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> login({
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.login(
      countryCode: countryCode,
      phone: phone,
      password: password,
    );

    if (response.status) {
      final user = UserModel.fromJson(response.data['data']);
      await _saveUser(user);
      emit(AuthVerifySuccess(user));
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> forgotPassword({
    required String countryCode,
    required String phone,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.forgotPassword(
      countryCode: countryCode,
      phone: phone,
    );

    if (response.status) {
      emit(AuthForgotPasswordSuccess(response.message));
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirm,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.resetPassword(
      resetToken: resetToken,
      password: password,
      passwordConfirm: passwordConfirm,
    );

    if (response.status) {
      emit(AuthResetPasswordSuccess(response.message));
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> resendOtp({
    required String countryCode,
    required String phone,
    required String purpose,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.resendOtp(
      countryCode: countryCode,
      phone: phone,
      purpose: purpose,
    );

    if (response.status) {
      emit(AuthResendOtpSuccess(response.message));
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> verifyOtp({
    required String countryCode,
    required String phone,
    required String code,
    required String purpose,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.verifyOtp(
      countryCode: countryCode,
      phone: phone,
      code: code,
      purpose: purpose,
    );

    if (response.status) {
      if (purpose == 'reset') {
        final resetToken = response.data['data']['resetToken'];
        emit(AuthVerifyOtpForResetSuccess(resetToken));
      } else {
        final user = UserModel.fromJson(response.data['data']);
        await _saveUser(user);
        emit(AuthVerifySuccess(user));
      }
    } else {
      emit(AuthError(response.message));
    }
  }

  Future<void> changePassword({
    required String password,
    required String newPassword,
    required String passwordConfirm,
  }) async {
    emit(AuthLoading());
    final response = await _authRepository.changePassword(
      password: password,
      newPassword: newPassword,
      passwordConfirm: passwordConfirm,
    );
    if (response.status) {
      emit(AuthChangePasswordSuccess(response.message));
    } else {
      emit(AuthError(response.message));
    }
  }

  // ─── Save user to SharedPreferences + token to SecureStorage ─────────
  Future<void> _saveUser(UserModel user) async {
    // Save token securely
    await LocalData.saveToken(user.token);

    // Save non-sensitive profile data in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_phone', user.phone);
  }

  // ─── Load user on app start ───────────────────────────────────────────
  Future<void> loadUser() async {
    emit(AuthLoading());
    // Load token from SecureStorage
    await LocalData.loadTokens();

    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name');
    final id = prefs.getString('user_id');
    final phone = prefs.getString('user_phone');
    final token = LocalData.accessToken;

    if (token != null && name != null && id != null && phone != null) {
      final user = UserModel(
        id: id,
        name: name,
        phone: phone,
        token: token,
        countryCode: '',
        role: 'user',
        isEmailVerified: false,
        isPhoneVerified: true,
        isActive: true,
      );
      emit(AuthVerifySuccess(user));
    } else {
      emit(AuthInitial());
    }
  }

  // ─── Logout ───────────────────────────────────────────────────────────
  Future<void> logout() async {
    // Clear token from SecureStorage
    await LocalData.clearTokens();

    // Clear profile data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    emit(AuthInitial());
  }

  // ─── Legacy alias kept for backward compatibility ─────────────────────
  @Deprecated('Use _saveUser internally. Token is now saved in SecureStorage.')
  Future<void> saveUser(UserModel user) => _saveUser(user);
}
