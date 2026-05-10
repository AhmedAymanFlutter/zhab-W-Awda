import 'validation_rule.dart';

class InputValidator {
  final List<ValidationRule> rules;

  InputValidator(this.rules);

  String? validate(String? value) {
    for (var rule in rules) {
      final result = rule.validate(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
