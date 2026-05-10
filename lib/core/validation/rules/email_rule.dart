import '../validation_rule.dart';

class EmailRule extends ValidationRule {
  final String message;

  EmailRule({this.message = 'البريد الإلكتروني غير صحيح'});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return message;
    }
    return null;
  }
}
