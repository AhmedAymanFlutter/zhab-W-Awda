import 'package:intl/intl.dart';

class DateFormatter {
  static String formatArabicDate(String? dateStr) {
    if (dateStr == null) return "";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d مايو yyyy', 'ar').format(date);
    } catch (e) {
      return "";
    }
  }

  static String formatArabicDateTime(String? dateStr) {
    if (dateStr == null) return "";
    try {
      final date = DateTime.parse(dateStr);
      final dayMonth = DateFormat('d مايو', 'ar').format(date);
      final time = DateFormat('h:mm a', 'ar').format(date);
      return "$dayMonth، $time";
    } catch (e) {
      return "";
    }
  }
}
