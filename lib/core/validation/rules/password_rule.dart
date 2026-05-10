import '../validation_rule.dart';

class PasswordRule extends ValidationRule {
  final int minLength;
  final String message;

  PasswordRule({
    this.minLength = 6,
    this.message = 'كلمة المرور يجب أن لا تقل عن 6 أحرف',
  });

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < minLength) {
      return message;
    }
    return null;
  }
}
