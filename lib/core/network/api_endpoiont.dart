abstract class EndPoints {
  static const String baseUrl = 'http://192.168.1.2:3000/api/v1/';

  // ─── Mobile Content Endpoints (Protected) ───────────────────────────
  static const String offers = 'mobile/offers/';
  static const String packages = 'mobile/packages/';
  static const String hotels = 'mobile/hotels';
  static const String tours = 'mobile/tours/';
  static const String cities = 'mobile/cities';
  static const String countries = 'mobile/countries';
  static const String airLines = 'mobile/airLines';
  static const String flightBookings = 'mobile/flightBookings';
  static const String services = 'mobile/services';
  static const String packageTypes = 'mobile/packageTypes';
  static const String settings = 'mobile/settings';
  static const String hotelsCountries = 'mobile/hotels/countries';
  static const String tourGuides = 'mobile/tourguides';
  static const String reviews = 'mobile/reviews';
  static const String savedTours = 'mobile/saved-tours';
  static const String myBookings = 'mobile/package-bookings/my';
  static const String rewardPackages = 'mobile/reward-packages';

  static const String authRegister = 'mobile/auth/register';
  static const String authLogin = 'mobile/auth/login';
  static const String authVerifyOtp = 'mobile/auth/verify-otp';
  static const String authForgotPassword = 'mobile/auth/forgot-password';
  static const String authResetPassword = 'mobile/auth/reset-password';
  static const String authResendOtp = 'mobile/auth/resend-otp';
  static const String authChangePassword = 'mobile/auth/change-password';
}
