import 'input_validator.dart';
import 'rules/required_rule.dart';
import 'rules/email_rule.dart';
import 'rules/phone_rule.dart';
import 'rules/password_rule.dart';

class AuthValidator {
  static String? validateName(String? value) {
    return InputValidator([
      RequiredRule(message: 'يرجى إدخال الاسم بالكامل'),
    ]).validate(value);
  }

  static String? validateEmail(String? value) {
    return InputValidator([
      RequiredRule(message: 'يرجى إدخال البريد الإلكتروني'),
      EmailRule(),
    ]).validate(value);
  }

  static String? validatePhone(String? value) {
    return InputValidator([
      RequiredRule(message: 'يرجى إدخال رقم الهاتف'),
      PhoneRule(),
    ]).validate(value);
  }

  static String? validatePassword(String? value) {
    return InputValidator([
      RequiredRule(message: 'يرجى إدخال كلمة المرور'),
      PasswordRule(),
    ]).validate(value);
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }
}
