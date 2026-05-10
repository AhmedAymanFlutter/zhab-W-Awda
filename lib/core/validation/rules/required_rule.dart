import '../validation_rule.dart';

class RequiredRule extends ValidationRule {
  final String message;

  RequiredRule({this.message = 'هذا الحقل مطلوب'});

  @override
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }
}
