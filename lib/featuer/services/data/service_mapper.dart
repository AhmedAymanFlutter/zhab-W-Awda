class ServiceMapper {
  static String getAssetPath(String? name) {
    if (name == null) return 'assets/servicePhoto/program.svg';

    final normalizedName = name.trim();

    if (normalizedName == 'البرامج والرحلات') {
      return 'assets/servicePhoto/program.svg';
    } else if (normalizedName == 'رحلات طيران') {
      return 'assets/servicePhoto/flight_trip.svg';
    } else if (normalizedName == 'تأجير سيارات') {
      return 'assets/servicePhoto/car_rent.svg';
    } else if (normalizedName == 'رحلات بحرية') {
      return 'assets/servicePhoto/boat_trip.svg';
    } else if (normalizedName == 'استئجار طائرة خاصة') {
      return 'assets/servicePhoto/flight_rent.svg';
    } else if (normalizedName == 'قطار الحرمين') {
      return 'assets/servicePhoto/train.svg';
    } else if (normalizedName == 'الباقات') {
      return 'assets/servicePhoto/package.svg';
    }

    // Default fallback
    return 'assets/servicePhoto/program.svg';
  }
}
