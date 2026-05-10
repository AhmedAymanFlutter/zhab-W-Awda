import '../validation_rule.dart';

class PhoneRule extends ValidationRule {
  final String message;

  PhoneRule({this.message = 'رقم الهاتف يجب أن يتراوح بين 7 و 15 رقم'});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 7 || value.length > 15) {
      return message;
    }
    return null;
  }
}
