import 'package:flutter_application_1/featuer/Auth/data/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final String message;
  AuthRegisterSuccess(this.message);
}

class AuthForgotPasswordSuccess extends AuthState {
  final String message;
  AuthForgotPasswordSuccess(this.message);
}

class AuthVerifyOtpForResetSuccess extends AuthState {
  final String resetToken;
  AuthVerifyOtpForResetSuccess(this.resetToken);
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;
  AuthResetPasswordSuccess(this.message);
}

class AuthResendOtpSuccess extends AuthState {
  final String message;
  AuthResendOtpSuccess(this.message);
}

class AuthVerifySuccess extends AuthState {
  final UserModel user;
  AuthVerifySuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthChangePasswordSuccess extends AuthState {
  final String message;
  AuthChangePasswordSuccess(this.message);
}
